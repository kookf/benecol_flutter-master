
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageInput extends StatelessWidget {
  MessageInput({
    Key? key,
    required this.selectedField,
    required this.onFocusCallback,
    required this.onValidateCallback,
    required this.onChangeCallback,
    required this.onSavedCallback
  }) :  super(key: key);

  final String selectedField;
  late final void Function(bool) onFocusCallback;
  late final String? Function(String? value) onValidateCallback;
  late final String? Function(String? value) onChangeCallback;
  late final void Function(String? newValue) onSavedCallback;

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Container(
      // padding: EdgeInsets.only(bottom: getPropScreenWidth(5)),
      padding: EdgeInsets.only(bottom: 5),
      height: 350,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: selectedField =='message' ? kSecondaryColor : kGreyColor,
          )
        )
      ),
      child: Focus(
        onFocusChange: onFocusCallback,
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: T.emailUsMessageFieldHit,
            hintStyle: TextStyle(
              color: Colors.grey
            ),
            errorStyle: TextStyle(height: 0),
          ),
          style: TextStyle(
            fontSize: 18,
            color: kSecondaryColor,
          ),
          textAlign: TextAlign.start,
          maxLines: null,
          onChanged: onChangeCallback,
          validator: onValidateCallback,
          onSaved: onSavedCallback
        ),
      ),
    );
  }
}