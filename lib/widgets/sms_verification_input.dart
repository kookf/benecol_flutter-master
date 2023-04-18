
import 'dart:async';
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SMSVerificationInput extends StatefulWidget {
  final String label;
  final bool focused;
  final List<String> options;
  final TextStyle? style;
  final DateFormat? format;
  final Color primaryColor;
  final Color secondaryColor;
  final String? initialValue;
  final String? Function() getPhoneValue;
  final void Function(bool)? onFocusCallback;
  final void Function(String?) onSavedCallback;
  final void Function(String)? onChangeCallback;
  final String? Function(String?) onValidateCallback;
  final void Function(Map<String, dynamic>) onClickSendSMSCallback;

  SMSVerificationInput({
    Key? key,
    this.style,
    this.format,
    this.initialValue,
    this.onChangeCallback,
    required this.label,
    required this.focused,
    required this.options,
    required this.primaryColor,
    required this.getPhoneValue,
    required this.secondaryColor,
    required this.onFocusCallback,
    required this.onSavedCallback,
    required this.onValidateCallback,
    required this.onClickSendSMSCallback,
  }) : super(key: key);

  @override
  _SMSVerificationInputState createState() => _SMSVerificationInputState();
}

class _SMSVerificationInputState extends State<SMSVerificationInput> {
  late FocusNode _focusNode;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  bool isActive = true;
  int countDown = 0;
  Timer timer = Timer(Duration.zero, ()=>{});

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _nodeAttachment = _focusNode.attach(context);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
        if(widget.onFocusCallback!=null){
          widget.onFocusCallback!(_focused);
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    timer.cancel();
    super.dispose();
  }

  void focusDetector(){
    if (_focused) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    _nodeAttachment.reparent();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 17,
                color: widget.primaryColor
              ),
            ),
            padding: EdgeInsets.only(right: 20)
          ),
          Expanded(
            child: Focus(
              onFocusChange: widget.onFocusCallback,
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
                    errorStyle: TextStyle(height: 0),
                    isDense: true,
                  ),
                  style: TextStyle(
                    fontSize: 17,
                    color: widget.secondaryColor,
                  ),
                  textAlign: TextAlign.end,
                  cursorColor: widget.secondaryColor,
                  onSaved: widget.onSavedCallback,
                  onChanged: widget.onChangeCallback,
                  validator: widget.onValidateCallback,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
            child: TextButton(
              onPressed: () async {
                if(!isActive) return; 
                String? phoneToSend = widget.getPhoneValue();
                Map<String, dynamic> result = {};
                // print('Got phone: $phoneToSend');
                if(phoneToSend == null || phoneToSend == ''){
                  //check if phone empty
                  result['success'] = false;
                  result['error'] = 'EMPTY_PHONE_ERROR';
                }else if(!phoneRegExp.hasMatch(phoneToSend)){
                  //check if phone valid
                  result['success'] = false;
                  result['error'] = 'INVALID_PHONE_ERROR';
                }else{
                  //if yes call provider and api
                  String currentLangId = getCurrentLangId(context).toString();
                  // try {
                  //   this.storage.get("x_token").then(x_token => {
                  //     if(x_token) {
                  //       token = x_token;
                  //     }
                  //   });

                  // } catch(e) {
                  //   token = "";
                  // }
                  String token;
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? xToken = prefs.getString('xToken');
                  if(xToken != null){
                    token = xToken;
                  }else{
                    token = "";
                  }
                  // print('api token $token');
                  // xToken = 'newToken';
                  // await prefs.setString('xToken', xToken);

                  EasyLoading.show();
                  result = await context.read<AuthProvider>().getCaptcha(currentLangId, phoneToSend, token);
                  EasyLoading.dismiss();
                  print(result);

                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  if(result['token'] != null){
                    await prefs.setString('xToken', result['token']);
                  }

                  if(result['success'] == true){
                    //if success, change to countdown state
                    setState(() {
                      isActive = false;
                      countDown = 60;
                    });
                    timer = Timer.periodic(Duration(seconds: 1), (timer){
                      print(timer.tick);
                      setState(() {
                        countDown = countDown - 1;
                      });
                      if(countDown == 0){
                        setState(() {
                          isActive = true;
                          timer.cancel();
                        });
                      }
                    });
                  }else{
                    //else show error again
                    result['success'] = false;
                    result['error'] = 'GET_CAPTCHA_API_ERROR';
                  }
                }
                widget.onClickSendSMSCallback(result);
              }, 
              child: Text(
                '${T.signupGetCaptchaText}${countDown>0?' $countDown':''}'
              ),
              style: TextButton.styleFrom(
                primary: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: isActive ? Colors.white : Colors.white.withOpacity(0.5))
                ),
                padding: EdgeInsets.symmetric(horizontal: 5),
                textStyle: TextStyle(
                    fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: widget.focused 
            ? widget.secondaryColor 
            : widget.primaryColor
          )
        )
      )
    );
  }
}