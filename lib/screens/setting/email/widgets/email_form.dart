
import 'package:benecol_flutter/screens/setting/email/widgets/buttom_button.dart';
import 'package:benecol_flutter/screens/setting/email/widgets/contact_input.dart';
import 'package:benecol_flutter/screens/setting/email/widgets/email_input.dart';
import 'package:benecol_flutter/screens/setting/email/widgets/error_text.dart';
import 'package:benecol_flutter/screens/setting/email/widgets/message_input.dart';
import 'package:benecol_flutter/screens/setting/email/widgets/name_input.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({
    Key? key,
  }) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedField = '';
  bool _submittedBefore = false;
  late String _name;
  late String _phone;
  late String _email;
  late String _message;
  final List<String> errors = [];

  void addError({required String error}){
    if(!errors.contains(error)){
      setState((){
        errors.add(error);
      });
    }
  }

  void removeError({required String error}){
    if(errors.contains(error)){
      setState((){
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildNameField(T),
                  if(errors.contains(T.emailUsNameFieldError))
                  ErrorText(errorString: T.emailUsNameFieldError),
                  SizedBox(height: 3),
                  buildContactField(T),
                  if(errors.contains(T.emailUsPhoneFieldError))
                  ErrorText(errorString: T.emailUsPhoneFieldError),
                  SizedBox(height: 3),
                  buildEmailField(T),
                  if(errors.contains(T.emailUsEmailFieldError))
                  ErrorText(errorString: T.emailUsEmailFieldError),
                  SizedBox(height: 3),
                  buildMessageField(T),
                  if(errors.contains(T.emailUsMessageFieldError))
                  ErrorText(errorString: T.emailUsMessageFieldError),
                  SizedBox(height: 25),
                ],
              )
            ),
          ),
        ),
        BottomButton(
          press: () async {
            _submittedBefore = true;
            if(_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              Map<String, String> _sendObj = {
                'name': _name,
                'phone': _phone,
                'email': _email,
                'message': _message
              };
              EasyLoading.show();
              bool success = await context.read<SettingProvider>().sendEmail(_sendObj);
              EasyLoading.dismiss();
              if(success){
                textDialog(context: context, content: T.emailUsSendSuccess);
              }else{
                textDialog(context: context, content: T.emailUsSendFail);
              }
            }
          }
        )
      ],
    );
  }

  MessageInput buildMessageField(AppLocalizations T) {
    return MessageInput(
      selectedField: _selectedField, 
      onSavedCallback: (newValue) => _message = newValue!,
      onFocusCallback: (hasFocus) {
        if(hasFocus) {
          setState(() {
            _selectedField = 'message';
          });
        }
      },
      onValidateCallback: (String? value) {
        if(value == null || value.isEmpty){
          addError(error: T.emailUsMessageFieldError);
          return '';
        }
        return null;
      },
      onChangeCallback: (String? value){
        if(!_submittedBefore) return '';
        if(value != null && value.isNotEmpty){
          removeError(error: T.emailUsMessageFieldError);
          return '';
        }else{
          addError(error: T.emailUsMessageFieldError);
        }
      }
    );
  }

  EmailInput buildEmailField(AppLocalizations T) {
    return EmailInput(
      selectedField: _selectedField,
      onSavedCallback: (newValue) => _email = newValue!,
      onFocusCallback: (hasFocus) {
        if(hasFocus) {
          setState(() {
            _selectedField = 'email';
          });
        }
      },
      onValidateCallback: (String? value) {
        if(value == null || value.isEmpty || !emailRegExp.hasMatch(value)){
          addError(error: T.emailUsEmailFieldError);
          return '';
        }
        return null;
      },
      onChangeCallback: (String? value){
        if(!_submittedBefore) return '';
        if(value != null && value.isNotEmpty && emailRegExp.hasMatch(value)){
          removeError(error: T.emailUsEmailFieldError);
          return '';
        }else{
          addError(error: T.emailUsEmailFieldError);
        }
      }
    );
  }

  ContactInput buildContactField(AppLocalizations T) {
    return ContactInput(
      selectedField: _selectedField,
      onSavedCallback: (newValue) => _phone = newValue!,
      onFocusCallback: (hasFocus) {
        if(hasFocus) {
          setState(() {
            _selectedField = 'contact';
          });
        }
      },
      onValidateCallback: (String? value) {
        if(value == null || value.isEmpty || !phoneRegExp.hasMatch(value)){
          addError(error: T.emailUsPhoneFieldError);
          return '';
        }
        return null;
      },
      onChangeCallback: (String? value){
        if(!_submittedBefore) return '';
        if(value != null && value.isNotEmpty && phoneRegExp.hasMatch(value)){
          removeError(error: T.emailUsPhoneFieldError);
          return '';
        }else{
          addError(error: T.emailUsPhoneFieldError);
        }
      }
    );
  }

  NameInput buildNameField(AppLocalizations T) {
    return NameInput(
      selectedField: _selectedField,
      onSavedCallback: (newValue) => _name = newValue!,
      onFocusCallback: (hasFocus) {
        if(hasFocus) {
          setState(() {
            _selectedField = 'name';
          });
        }
      },
      onValidateCallback: (String? value) {
        if(value == null || value.isEmpty){
          addError(error: T.emailUsNameFieldError);
          return '';
        }
        return null;
      },
      onChangeCallback: (String? value){
        if(!_submittedBefore) return '';
        if(value != null && value.isNotEmpty){
          removeError(error: T.emailUsNameFieldError);
          return '';
        }else{
          addError(error: T.emailUsNameFieldError);
        }
      }
    );
  }
}