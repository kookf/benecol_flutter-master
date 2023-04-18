import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/profile_edit/widgets/profile_edit_form_controller.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/models/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEditForm extends StatefulWidget {
  ProfileEditFormController controller;

  ProfileEditForm({ 
    Key? key,
    required this.controller
  }) : super(key: key);

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState(controller);
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  bool submited = false;
  String focusField = '';
  List<String> errors = [];
  late Map<String, String> errorMap;
  late Profile userProfile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final oldPasswordFieldController = TextEditingController();
  final newPasswordFieldController = TextEditingController();
  final newConfirmPasswordFieldController = TextEditingController();

  String email = '';
  String lastName = '';
  String name = '';
  String phone = '';
  String birthdate = '';
  String gender = '';
  String district = '';
  String income = '';

  String oldPassword = '';
  String newPassword = '';
  String newConfirmPassword = '';

  late AppLocalizations T;

  _ProfileEditFormState(ProfileEditFormController _controller) {
    _controller.submit = submit;
  }

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

  void submit(BuildContext context) async {
    // print('form submit');
    setState(() {
      submited = true;
    });
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      Map<String, dynamic> _profile = {
        "email":email,
        "last_name":lastName,
        "first_name":name,
        "phone":phone,
        "age":"",
        "birthday":birthdate,
        "gender":gender,
        "area_id":district,
        "income":income,
        "current_password":oldPassword,
        "new_password":newPassword,
        "new_password_confirmation":newConfirmPassword,
      };

      var result = await context.read<UserProvider>().updateProfile(context, _profile);
      bool isSuccess = result['success'];
      if(isSuccess){
        // TODO: update credential
      }else{
        if(result['type']=="INVALID_PASSWORD_ERROR"){
          // TODO: reset password field;
        }
      }
    }else{
      print('form error');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    oldPasswordFieldController.dispose();
    newPasswordFieldController.dispose();
    newConfirmPasswordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    userProfile = context.watch<UserProvider>().userProfile;

    errorMap = {
      "LASTNAME_ERROR": T.profileEditEmailFieldError,
      "NAME_ERROR": T.profileEditNameFieldError,
      "GENDER_ERROR": T.profileEditGenderFieldError,
      "DISTRICT_ERROR": T.profileEditDistrictFieldError,
      "INCOME_ERROR": T.profileEditIncomeFieldError,
      "EMPTY_OLD_PASSWORD_ERROR": T.profileEditEmptyOldPasswordError,
      "OLD_PASSWORD_ERROR": T.profileEditOldPasswordError,
      "EMPTY_NEW_PASSWORD_ERROR": T.profileEditEmptyNewPasswordError,
      "NEW_PASSWORD_ERROR": T.profileEditNewPasswordError,
      "NEW_CONFIRM_PASSWORD_ERROR": T.profileEditNewConfirmPasswordError
    };

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10
        ),
        child: Column(
          children: [
            buildEmailField(),
            buildLastNameField(),
            buildNameField(),
            buildPhoneField(),
            buildBirthDateField(),
            buildGenderField(),
            buildDistrictField(),
            buildIncomeField(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 35,
                bottom: 5,
              ),
              child: Text(
                T.profileEditChangePasswordOptionTitle,
                style: TextStyle(
                  fontSize: 13
                )
              ),
            ),
            buildPasswordField(),
            buildNewPasswordField(),
            buildNewPasswordConfirmField()
          ],
        ),
      ),
    );
  }

  Column buildEmailField() {
    return Column(
      children: [
        MyTextInput(
          label: T.profileEditEmailField,
          enable: false,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          initialValue: userProfile.email,
          type: TextInputType.emailAddress,
          focused: focusField == 'email',
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onFocusCallback: (hasFocus) {},
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
            email = newValue ?? '';
          },
        ),
      ],
    );
  }

  Column buildLastNameField() {
    return Column(
      children: [
        MyTextInput(
          label: T.profileEditLastNameField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          initialValue: userProfile.lastName,
          focused: focusField == 'lastname',
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
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
            lastName = newValue??'';
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
          label: T.profileEditNameField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          initialValue: userProfile.firstName,
          focused: focusField == 'name',
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
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
            name = newValue ?? '';
          },
        ),
        buildFieldError('NAME_ERROR'),
      ],
    );
  }

  Column buildPhoneField() {
    return Column(
      children: [
        MyTextInput(
          enable: false,
          label: T.profileEditPhoneField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.number,
          initialValue: userProfile.phone,
          focused: focusField == 'phone',
          // controller: phoneFieldController,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onFocusCallback: (hasFocus) {},
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
            phone = newValue ?? '';
          },
        ),
        buildFieldError('PHONE_ERROR'),
      ],
    );
  }

  Column buildBirthDateField() { // BirthDateField can never be updated
    return Column(
      children: [
        MyTextInput(
          enable: false,
          label: T.profileEditBirthDateField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          initialValue: userProfile.birthday,
          focused: focusField == 'birthDate',
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onFocusCallback: (hasFocus) {},
          onValidateCallback: (String? value) {
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return;
            try{
              DateTime.parse(value!);
            }catch(e){
            }
          },
          onSavedCallback: (newValue){
            birthdate = newValue ?? '';
          },
        ),
      ],
    );
  }

  Column buildGenderField(){
    List<Map<String, String>> genderOptions = [
      {
        'value': 'm',
        'text': T.profileEditGenderMale
      },
      {
        'value': 'f',
        'text': T.profileEditGenderFemale
      }
    ];
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          label: T.profileEditGenderField,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: userProfile.gender,
          options: genderOptions,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          indicatorColor: Colors.grey,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'gender',
          placeholder: T.profileEditGenderFieldPlaceholder,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("GENDER_ERROR");
          },
          onSavedCallback: (newValue){
            gender = newValue ?? '';
          },
          onValidateCallback: (value){
            if(value == null || value.isEmpty) {
              addError("GENDER_ERROR");
              return '';  
            }
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
        'text': T.profileEditDistrictHk
      },
      {
        'value': '2',
        'text': T.profileEditDistrictKl
      },
      {
        'value': '3',
        'text': T.profileEditDistrictNt
      }
    ];
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          label: T.profileEditDistrictField,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: userProfile.areaId,
          options: districtOptions,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          focused: focusField == 'district',
          indicatorColor: Colors.grey,
          placeholder: T.profileEditDistrictFieldPlaceholder,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("DISTRICT_ERROR");
          },
          onSavedCallback: (newValue){
            district = newValue ?? '';
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
          label: T.profileEditIncomeField,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: userProfile.income,
          options: incomeOptions,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          focused: focusField == 'income',
          indicatorColor: Colors.grey,
          placeholder: T.profileEditIncomeFieldPlaceholder,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("INCOME_ERROR");
          },
          onSavedCallback: (newValue){
            income = newValue ?? '';
          },
          onValidateCallback: (value){
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
          label: T.profileEditCurrentPasswordField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'oldPassword',
          controller: oldPasswordFieldController,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'oldPassword';
              });
            }
          },
          onValidateCallback: (String? value) {
            if(value != null && value.isEmpty){
              var newPassword = newPasswordFieldController.text;
              if(newPassword.isEmpty){
                return null;
              }else{
                addError("EMPTY_OLD_PASSWORD_ERROR");
                return '';
              }
            }else{
              if(value != null && value.length < 8){
                addError("OLD_PASSWORD_ERROR");
                return '';
              }
            }
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isEmpty){
              var newPassword = newPasswordFieldController.text;
              if(newPassword.isEmpty){
                removeError('EMPTY_NEW_PASSWORD_ERROR');
                removeError('EMPTY_OLD_PASSWORD_ERROR');
                removeError('OLD_PASSWORD_ERROR');
                removeError('NEW_PASSWORD_ERROR');
                removeError('NEW_CONFIRM_PASSWORD_ERROR');
                return null;
              }else{
                addError("EMPTY_OLD_PASSWORD_ERROR");
                removeError('OLD_PASSWORD_ERROR');
                return '';
              }
            }else{
              if(value != null && value.length < 8){
                removeError("EMPTY_OLD_PASSWORD_ERROR");
                addError("OLD_PASSWORD_ERROR");
                return '';
              }else{
                removeError('OLD_PASSWORD_ERROR');
              }
            }
          },
          onSavedCallback: (newValue){
            oldPassword = newValue ?? '';
          },
        ),
        buildFieldError('EMPTY_OLD_PASSWORD_ERROR'),
        buildFieldError('OLD_PASSWORD_ERROR'),
      ],
    );
  }

  Column buildNewPasswordField() {
    return Column(
      children: [
        MyTextInput(
          label: T.profileEditNewPasswordField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'newPassword',
          controller: newPasswordFieldController,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'newPassword';
              });
            }
          },
          onValidateCallback: (String? value) {
            // print('[NEWPASSWORD] validating: $value');
            if(value == null || value.isEmpty){
              var oldPassword = oldPasswordFieldController.text;
              if(oldPassword.isEmpty){
                return null;
              }else{
                addError('EMPTY_NEW_PASSWORD_ERROR');
                return '';
              }
            }else{
              if(value.length < 8){
                addError('NEW_PASSWORD_ERROR');
              }
            }
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value == null || value.isEmpty){
              var oldPassword = oldPasswordFieldController.text;
              if(oldPassword.isEmpty){
                //no problem
                removeError('EMPTY_NEW_PASSWORD_ERROR');
                removeError('EMPTY_OLD_PASSWORD_ERROR');
                removeError('OLD_PASSWORD_ERROR');
                removeError('NEW_PASSWORD_ERROR');
                removeError('NEW_CONFIRM_PASSWORD_ERROR');
                return null;
              }else{
                addError('EMPTY_NEW_PASSWORD_ERROR');
                removeError('NEW_PASSWORD_ERROR');
                return '';
              }
            }else{
              if(value.length < 8){
                removeError('EMPTY_NEW_PASSWORD_ERROR');
                addError('NEW_PASSWORD_ERROR');
              }else{
                removeError('NEW_PASSWORD_ERROR');
              }
            }
          },
          onSavedCallback: (newValue){
            newPassword = newValue ?? '';
          },
        ),
        buildFieldError('EMPTY_NEW_PASSWORD_ERROR'),
        buildFieldError('NEW_PASSWORD_ERROR'),
      ],
    );
  }

  Column buildNewPasswordConfirmField() {
    return Column(
      children: [
        MyTextInput(
          label: T.profileEditNewConfirmPasswordField,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.text,
          focused: focusField == 'newConfirmPassword',
          controller: newConfirmPasswordFieldController,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'newConfirmPassword';
              });
            }
          },
          onValidateCallback: (String? value) {
            var newPassword = newPasswordFieldController.text;
            if(newPassword != value){
              addError('NEW_CONFIRM_PASSWORD_ERROR');
              return '';
            }else{
              return null;
            }
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            var newPassword = newPasswordFieldController.text;
            if(newPassword != value){
              addError('NEW_CONFIRM_PASSWORD_ERROR');
            }else{
              removeError('NEW_CONFIRM_PASSWORD_ERROR');
            }
          },
          onSavedCallback: (newValue){
            newConfirmPassword = newValue ?? '';
          },
        ),
        buildFieldError('NEW_CONFIRM_PASSWORD_ERROR'),
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