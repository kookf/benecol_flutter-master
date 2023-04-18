
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/profile_screen.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:benecol_flutter/services/myFirebase.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  Object? args;
  LoginForm({
    Key? key,
    this.args
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String focusField = '';
  List<String> errors = [];
  late Map<String, String> errorMap;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AppLocalizations T;
  bool submited = false;

  String email = '';
  String password = '';

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
  void initState(){
    super.initState();
    initEmailField();
  }

  void initEmailField(){
    LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
    _localStorageSingleton.getValue('email').then((value){
      setState(() {
        email = value ?? '';
      });
    });
  }

  void subscribeFirebaseTopicAccordingToUser(BuildContext context){
    print('[Login] subscribeFirebaseTopicAccordingToUser');
    if(email == 'jeff@ctrlf.hk'){
      MyFirebaseSingleton _myFirebase = new MyFirebaseSingleton();
      _myFirebase.subscribeTestingTopic();
      context.read<AuthProvider>().setIsRegisteredFirebasetestingTopic(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    errorMap = {
      "EMAIL_ERROR": T.signupEmailFieldError,
      "PASSWORD_ERROR": T.signupPasswordFieldError,
    };

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  buildEmailField(),
                  buildPasswordField(),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 18),
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.white)
                    )
                  )
                ),
                onPressed: () async {
                  print("form submit clicked");
                  setState(() {
                    submited = true;
                  });
                  if(_formKey.currentState!.validate()){
                    print('form passed');
                    _formKey.currentState!.save();
                    final Map<String, dynamic> login = {
                      'email': email,
                      'password': password,
                      'language': getCurrentLangId(context).toString(),
                    };
                    var result = await context.read<AuthProvider>().login(login);
                    if(result['isSuccess']){
                      LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
                      _localStorageSingleton.removeValue('noAutoInvoiceSample');                    
                      _localStorageSingleton.removeValue('noAutoCodeSample');                    
                      _localStorageSingleton.removeValue('noAutoUploadSample');
                      // subscribeFirebaseTopicAccordingToUser(context);
                      if(widget.args != null){
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          widget.args.toString(), 
                          (_) => false
                        );
                      }else{
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          ProfileScreen.routeName, 
                          (_) => false
                        );
                      }
                    }else{
                      String _errorMessage;
                      switch(result['statusCode']){
                        case (401):
                          _errorMessage = T.popupLoginDefaultError;
                          break;
                        case (406):
                          _errorMessage = T.popupLoginEmailNotVerifiedError;
                          break;
                        case (null):
                        default:
                          _errorMessage = T.popupLoginDefaultError;
                          break;
                      }
                      showNoIconMessageDialog(_errorMessage);
                    }
                  }
                }, 
                child: Text(
                  T.loginTitle,
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
    );
  }

  Column buildPasswordField() {
    return Column(
      children: [
        MyTextInput(
          label: T.loginPasswordField,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'password',
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'password';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(value == null || value.isEmpty || value.length < 8){
              addError("PASSWORD_ERROR");
              return '';
            }
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isNotEmpty && value.length >= 8){
              removeError("PASSWORD_ERROR");
              return '';
            }else{
              addError("PASSWORD_ERROR");
            }
          },
          onSavedCallback: (newValue){
            print('[PASSWORD] onSavedCallback');
            password = newValue!;
          },
        ),
        buildFieldError('PASSWORD_ERROR'),
      ],
    );
  }

  Column buildEmailField() {
    return Column(
      children: [
        MyTextInput(
          key: Key(email),
          label: T.loginEmailField,
          initialValue: email,
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