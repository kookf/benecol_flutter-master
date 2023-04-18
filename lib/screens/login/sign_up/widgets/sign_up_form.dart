
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/login/sign_up/widgets/sign_up_form_controller.dart';
import 'package:benecol_flutter/screens/setting/privacy/privacy_screen.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/date_time_select_input.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:benecol_flutter/widgets/sms_verification_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpForm extends StatefulWidget {
  SignUpFormController controller;

  SignUpForm({
    Key? key,
    required this.controller
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState(controller);
}

class _SignUpFormState extends State<SignUpForm> {
  bool submited = false;
  String focusField = '';
  List<String> errors = [];
  late Map<String, String> errorMap;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  bool smsSent = false;
  String captchReturned = '';
  late AppLocalizations T;
  bool agreePrivacy = false;
  bool popNullBirthday = false;

  String email = '';
  String lastName = '';
  String name = '';
  String gender = '';
  String birthdate = '';
  String district = '';
  String income = '';
  String password = '';
  String confirmPassword = '';
  String phone = '';
  String captcha = '';
  bool emailFlag = true;
  bool smsFlag = true;
  bool mailFlag = true;

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

  void submit() async{
    // print('submit clicked');
    setState(() {
      submited = true;
    });
    checkPrivacyAgreement();
    if(!_formKey.currentState!.validate() || !agreePrivacy){
    }else{
      _formKey.currentState!.save();
      final Map<String, dynamic> signup = {
        'email': email,
        'last_name': lastName,
        'first_name': name,
        'phone': phone,
        'age': '',
        'gender': gender,
        'birthday': birthdate,
        'area_id': district,
        'income': income,
        'password': password,
        'password_confirmation': confirmPassword,
        'flag_email': !!emailFlag?'1':'0',
        'flag_sms': !!smsFlag?'1':'0',
        'flag_phone': "1",
        'flag_mail': !!mailFlag?'1':'0',
        'language': getCurrentLangId(context).toString(),
        'invitation_code': ''
      };

      if(!checkBirthdayNull()){
        return;
      }

      EasyLoading.show();
      var result = await context.read<AuthProvider>().register(signup);
      EasyLoading.dismiss();
      bool isSuccess = result['success'];
      if(isSuccess){
        //Registration success
        showNoIconMessageDialog(T.popupSignupSuccess);
        Navigator.pop(context);
      }else{
        //Registration failure
        // print('Registration failure! $result');
        String errorMessage;
        switch(result['type']){
          case ('EMAIL_TAKEN'):
            errorMessage = T.popupSignupEmailTakenError;
            break;
          case ('PHONE_TAKEN'):
            errorMessage = T.popupSignupPhoneTakenError;
            break;
          case ('PHONE_FORMAT'):
            errorMessage = T.popupSignupPhoneFormatError;
            break;
          default:
            errorMessage = T.popupSignupError;
            break;
        }
        showNoIconMessageDialog(errorMessage);
      }
    }
  }

  _SignUpFormState(SignUpFormController _controller) {
    _controller.submit = submit;
  }

  void openPrivacyModal(){
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => StoreMapScreen(store: store),
        builder: (context) => PrivacyScreen(),
      ),
    );
  }

  void checkPrivacyAgreement(){
    if(!agreePrivacy){
      addError("PRIVACY_ERROR");
    }else{
      removeError("PRIVACY_ERROR");
    }
  }

  bool checkBirthdayNull(){
    if(birthdate == '' && !popNullBirthday){
      promtBirthdayNullReminder();
      return false;
    }else{
      return true;
    }
  }

  void promtBirthdayNullReminder(){
    showSheet(
      context,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15
        ),
        child: Text(
          T.signupBirthdateNullReminder,
          style: TextStyle(
            fontSize: 18
          )
        ),
      ),
      onClicked: (){
        setState(() {
          popNullBirthday = true;
        });
        Navigator.pop(context);
      },
      actionText: T.dialogConfirm,
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    errorMap = {
      "EMAIL_ERROR": T.signupEmailFieldError,
      "LASTNAME_ERROR": T.signupLastNameFieldError,
      "NAME_ERROR": T.signupNameFieldError,
      "BIRTHDATE_ERROR": T.signupBirthDateFieldError,
      "GENDER_ERROR": T.signupGenderFieldError,
      "DISTRICT_ERROR": T.signupDistrictFieldError,
      "INCOME_ERROR": T.signupIncomeFieldError,
      "PASSWORD_ERROR": T.signupPasswordFieldError,
      "CONFIRM_PASSWORD_ERROR": T.signupConfirmPasswordFieldError,
      "PHONE_ERROR": T.signupPhoneFieldError,
      "SMS_ERROR": T.signupCaptchaFieldError,
      "EMPTY_PHONE_ERROR": T.signupEmptyPhoneFieldError,
      "PRIVACY_ERROR": T.signupPrivacyAgreementError
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailField(),
          buildLastNameField(),
          buildNameField(),
          buildGenderField(),
          buildBirthDateField(),
          buildDistrictField(),
          buildIncomeField(),
          buildPasswordField(),
          buildConfirmPasswordField(),
          buildPhoneField(),
          buildSMSField(),
          buildFlagColumn(),
          SizedBox(height: 15),
          buildPrivacy(),
          SizedBox(height: 15)
        ],
      ),
    );
  }

  Column buildPrivacy() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  agreePrivacy = !agreePrivacy;
                });
                if(submited){
                  checkPrivacyAgreement();
                }
              },
              child: Icon(
                !!agreePrivacy ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.white,
                size: 18
              ),
            ),
            SizedBox(width: 5),
            Text(
              T.signupPrivacyAgreementPrefix,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )
            ),
            GestureDetector(
              onTap: openPrivacyModal,
              child: Text(
                T.signupPrivacyAgreementSuffix,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                )
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        buildFieldError('PRIVACY_ERROR'),
      ],
    );
  }

  Column buildFlagColumn() {
    Expanded buildFlagSingle(VoidCallback onPress, String label, bool isFlagOn) {
      return Expanded(
        child: GestureDetector(
          onTap: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                !!isFlagOn ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.white,
                size: 18
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                )
              )
            ],
          ),
        )
      );
    }

    return Column(
      children: [
        Row(
          children:[ 
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: T.signupFlagColumnHeaderPrefix,
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.check_box, 
                          size: 16,
                          color: Colors.white
                        ),
                      ),
                      TextSpan(
                        text: T.signupFlagColumnHeaderSuffix,
                      ),
                    ],
                  ),
                )
              )
            )
          ]
        ),
        Row(
          children: [
            buildFlagSingle(
              (){
                setState(() {
                  emailFlag = !emailFlag;
                });
              },
              T.signupFlagColumnEmailLabel,
              emailFlag
            ),
            buildFlagSingle(
              (){
                setState(() {
                  smsFlag = !smsFlag;
                });
              },
              T.signupFlagColumnSmsLabel,
              smsFlag
            ),
            buildFlagSingle(
              (){
                setState(() {
                  mailFlag = !mailFlag;
                });
              },
              T.signupFlagColumnMailLabel,
              mailFlag
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.white
                )
              )
            )
          ],
        )
      ],
    );
  }

  Column buildEmailField() {
    return Column(
      children: [
        MyTextInput(
          label: T.signupEmailFieldTitle,
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
            // print('[EMAIL] onSavedCallback');
            email = newValue!;
          },
        ),
        buildFieldError('EMAIL_ERROR'),
      ],
    );
  }


  Column buildLastNameField() {
    return Column(
      children: [
        MyTextInput(
          label: T.signupLastNameFieldTitle,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'lastname',
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'lastname';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(value == null || value.isEmpty){
              addError("LASTNAME_ERROR");
              return '';
            }
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isNotEmpty){
              removeError("LASTNAME_ERROR");
              return '';
            }else{
              addError("LASTNAME_ERROR");
            }
          },
          onSavedCallback: (newValue){
            // print('[LASTNAME] onSavedCallback');
            lastName = newValue!;
          },
        ),
        buildFieldError('LASTNAME_ERROR'),
      ],
    );
  }

  Column buildNameField() {
    return Column(
      children: [
        MyTextInput(
          label: T.signupNameFieldTitle,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'name',
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'name';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(value == null || value.isEmpty){
              addError("NAME_ERROR");
              return '';
            }
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isNotEmpty){
              removeError("NAME_ERROR");
              return '';
            }else{
              addError("NAME_ERROR");
            }
          },
          onSavedCallback: (newValue){
            // print('[NAME] onSavedCallback');
            name = newValue!;
          },
        ),
        buildFieldError('NAME_ERROR'),
      ],
    );
  }

  Column buildBirthDateField(){
    return Column(
      children: [
        DateTimeSelectInput(
          //--------Required--------
          label: T.signupBirthDateFieldTitle,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: '',
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'birthDate',
          placeholder: 'YYYY-MM-DD',
          onChangeCallback: (value){
            if(!submited) return;
            try{
              DateTime.parse(value);
              removeError("BIRTHDATE_ERROR");
            }catch(e){
            }
          },
          onSavedCallback: (newValue){
            // print('[BIRTHDATE] onSavedCallback');
            birthdate = newValue!;
          },
          onValidateCallback: (value){
            // try{
            //   DateTime.parse(value!);
            //   return null;
            // }catch(e){
            //   addError("BIRTHDATE_ERROR");
            //   return '';
            // }
            return null;
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'birthDate';
              });
            }
          },
        ),
        buildFieldError('BIRTHDATE_ERROR'),
      ],
    );
  }

  Column buildGenderField(){
    List<Map<String, String>> genderOptions = [
      {
        'value': '',
        'text': '--'
      },
      {
        'value': 'm',
        'text': T.signupGenderMale
      },
      {
        'value': 'f',
        'text': T.signupGenderFemale
      }
    ];
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          label: T.signupGenderFieldTitle,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: '',
          options: genderOptions,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'gender',
          placeholder: T.signupGenderFieldPlaceholder,
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("GENDER_ERROR");
          },
          onSavedCallback: (newValue){
            // print('[GENDER] onSavedCallback');
            gender = newValue!;
          },
          onValidateCallback: (value){
            // if(value == null || value.isEmpty) {
            //   addError("GENDER_ERROR");
            //   return '';
            // }
            return null;
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'gender';
              });
            }
          },
        ),
        buildFieldError('GENDER_ERROR'),
      ],
    );
  }

  Column buildDistrictField(){
    List<Map<String, String>> districtOptions = [
      {
        'value': '1',
        'text': T.signupDistrictHk
      },
      {
        'value': '2',
        'text': T.signupDistrictKl
      },
      {
        'value': '3',
        'text': T.signupDistrictNt
      }
    ];
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          label: T.signupDistrictFieldTitle,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: '',
          options: districtOptions,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'district',
          placeholder: T.signupDistrictFieldPlaceholder,
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("DISTRICT_ERROR");
          },
          onSavedCallback: (newValue){
            // print('[DISTRICT] onSavedCallback');
            district = newValue!;
          },
          onValidateCallback: (value){
            if(value == null || value.isEmpty) {
              addError("DISTRICT_ERROR");
              return '';  
            }
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'district';
              });
            }
          },
        ),
        buildFieldError('DISTRICT_ERROR'),
      ],
    );
  }

  Column buildIncomeField(){
    List<Map<String, String>> incomeOptions = [
      {
        'value': '',
        'text': '--'
      },
      {
        'value': 'below_9999',
        'text': 'HK\$0-\$9,999'
      },
      {
        'value': '10000_19000',
        'text': 'HK\$10,000-\$19,999'
      },
      {
        'value': '20000_29000',
        'text': 'HK\$20,000-\$29,999'
      },
      {
        'value': 'above_30000',
        'text': '> HK\$30,000'
      }
    ];
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          label: T.signupIncomeFieldTitle,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: '',
          options: incomeOptions,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'income',
          placeholder: T.signupIncomeFieldPlaceholder,
          onChangeCallback: (value){
            if(!submited) return;
            // if(value != null && value.isNotEmpty) removeError("INCOME_ERROR");
          },
          onSavedCallback: (newValue){
            if(newValue==null){
              income = '';
            }else{
              income = newValue;
            }
          },
          onValidateCallback: (value){
            // if(value == null || value.isEmpty) addError("INCOME_ERROR");
            return null;
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'income';
              });
            }
          },
        ),
        buildFieldError('INCOME_ERROR'),
      ],
    );
  }

  Column buildPasswordField() {
    return Column(
      children: [
        MyTextInput(
          label: T.signupPasswordFieldTitle,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'password',
          controller: passwordFieldController,
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
            // print('[PASSWORD] onSavedCallback');
            password = newValue!;
          },
        ),
        buildFieldError('PASSWORD_ERROR'),
      ],
    );
  }

  Column buildConfirmPasswordField() {
    return Column(
      children: [
        MyTextInput(
          label: T.signupConfirmPasswordFieldTitle,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'confirmPassword',
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'confirmPassword';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(passwordFieldController.text != value){
              addError("CONFIRM_PASSWORD_ERROR");
              return '';
            }
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(passwordFieldController.text == value){
              removeError("CONFIRM_PASSWORD_ERROR");
              return '';
            }else{
              addError("CONFIRM_PASSWORD_ERROR");
            }
          },
          onSavedCallback: (newValue){
            confirmPassword = newValue!;
          },
        ),
        buildFieldError('CONFIRM_PASSWORD_ERROR'),
      ],
    );
  }

  Column buildPhoneField() {
    return Column(
      children: [
        MyTextInput(
          label: T.signupPhoneFieldTitle,
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          type: TextInputType.number,
          focused: focusField == 'phone',
          controller: phoneFieldController,
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'phone';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(value == null || value.isEmpty || !phoneRegExp.hasMatch(value)){
              addError("PHONE_ERROR");
              return '';
            }
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isNotEmpty && phoneRegExp.hasMatch(value)){
              removeError("PHONE_ERROR");
              return '';
            }else{
              addError("PHONE_ERROR");
            }
          },
          onSavedCallback: (newValue){
            // print('[PHONE] onSavedCallback');
            phone = newValue!;
          },
        ),
        buildFieldError('PHONE_ERROR'),
      ],
    );
  }

  Column buildSMSField() {
    return Column(
      children: [
        SMSVerificationInput(
          //--------Required--------
          label: T.signupCaptchaFieldTitle,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: '',
          options: [],
          primaryColor: Colors.white,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'sms',
          getPhoneValue: (){
            //get phone input field value and return
            // print('This is the phoneFieldValue: ${phoneFieldController.text}');
            return phoneFieldController.text;
          },
          onChangeCallback: (value){
            if(!smsSent) return;
            if(captchReturned != value){
              addError('SMS_ERROR');
            }else{
              removeError('SMS_ERROR');
            }
          },
          onSavedCallback: (value){},
          onValidateCallback: (value){
            if(!smsSent || smsSent && captchReturned != value){
              addError('SMS_ERROR');
              return '';
            }
            return null;
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'sms';
              });
            }
          },
          onClickSendSMSCallback: (result){
            // print('onClickEndSMSCallback: $result');
            if(result['success'] == true && result['captcha'].toString().isNotEmpty){
              removeError('SMS_ERROR');
              removeError('EMPTY_PHONE_ERROR');
              setState(() {
                smsSent = true;
                captchReturned = result['captcha'].toString();
              });
            }
            if(result['success'] == false){
              switch(result['error']){
                case ('EMPTY_PHONE_ERROR'):
                  addError('EMPTY_PHONE_ERROR');
                  removeError('SMS_ERROR');
                  setState(() {
                    smsSent = false;
                  });
                  break;
                case ('GET_CAPTCHA_API_ERROR'):
                case ('INVALID_PHONE_ERROR'):
                  addError('SMS_ERROR');
                  removeError('EMPTY_PHONE_ERROR女');
                  setState(() {
                    smsSent = false;
                  });
                  break;
              }
            }
          }
        ),
        if(smsSent)
        Row(
          children: [
            Expanded(
              child: Text(
                T.signupSmsSentText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                )
              ),
            ),
          ],
        ),
        buildFieldError('EMPTY_PHONE_ERROR'),
        buildFieldError('SMS_ERROR'),
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