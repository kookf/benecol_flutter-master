import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordBodyState createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String focusField = '';
  List<String> errors = [];
  late Map<String, String> errorMap;
  late AppLocalizations T;
  bool submited = false;
  String email = '';

  void addError(errorType){
    if(errors.contains(errorType)) return;
    setState(() {
      errors.add(errorType);
    });
  }
  void removeError(errorType){
    if(!errors.contains(errorType)) return;
    setState(() {
      errors.remove(errorType);
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    errorMap = {
      "EMAIL_ERROR": T.signupEmailFieldError
    };

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                T.forgetPasswordHeader,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300
                )
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        children: [
                          buildEmailField(),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 30),
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 10)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.white)
                            )
                          ),
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                          animationDuration: Duration.zero
                        ),
                        onPressed: () async {
                          setState(() {
                            submited = true;
                          });
                          if(!_formKey.currentState!.validate()){
                            // print('form fail');
                          }else{
                            _formKey.currentState!.save();
                            final Map<String, dynamic> forgetPassword = {
                              'email': email,
                              'language': getCurrentLangId(context).toString(),
                            };

                            // print('form passed with langId: ${getCurrentLangId(context).toString()}');
                            EasyLoading.show();
                            var result = await context.read<AuthProvider>().forgetPassword(forgetPassword);
                            EasyLoading.dismiss();
                            bool isSuccess = result['success'];
                            if(isSuccess){
                              //Registration success
                              showNoIconMessageDialog(T.popupForgetPasswordResetPasswordSuccess);
                            }else{
                              //Registration failure
                              showNoIconMessageDialog(T.popupForgetPasswordResetPasswordFail);
                            }
                          }
                        }, 
                        child: Text(
                          T.forgetPasswordFormSubmitBtn,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white
                          )
                        )
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),      
    );
  }

  Column buildEmailField() {
    return Column(
      children: [
        MyTextInput(
          label: T.forgetPasswordEmailField,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.emailAddress,
          focused: focusField == 'email',
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'email';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(value == null || value.isEmpty || !emailRegExp.hasMatch(value)){
              addError("EMAIL_ERROR");
              return '';
            }
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isNotEmpty && emailRegExp.hasMatch(value)){
              removeError("EMAIL_ERROR");
              return '';
            }else{
              addError("EMAIL_ERROR");
            }
          },
          onSavedCallback: (newValue){
            print('[EMAIL] onSavedCallback');
            email = newValue!;
          },
        ),
        buildFieldError('EMAIL_ERROR'),
      ],
    );
  }

  Row buildFieldError(errorType) {
    return Row(
      children: [
        if(errors.contains(errorType))
        Expanded(
          child: Text(
            errorMap[errorType]!,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14
            )
          ),
        ),
      ],
    );
  }
}