
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactInput extends StatelessWidget {
  ContactInput({
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
      // padding: EdgeInsets.only(bottom: getPropScreenWidth(0)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: selectedField =='contact' ? kSecondaryColor : kGreyColor,
          )
        )
      ),
      child: Row(
        children: [
          Container(
            child: Text(
              T.emailUsPhoneFieldTitle,
              style: TextStyle(
                // fontSize: getPropScreenWidth(18),
                fontSize: 18,
                color: kPrimaryColor
              ),
            ),
            // padding: EdgeInsets.only(right: getPropScreenWidth(20))
            padding: EdgeInsets.only(right: 20)
          ),
          Expanded(
            child: Focus(
              onFocusChange: onFocusCallback,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
                  errorStyle: TextStyle(height: 0),
                  isDense: true,
                ),
                style: TextStyle(
                  // fontSize: getPropScreenWidth(18),
                  fontSize: 18,
                  color: kSecondaryColor,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                onChanged: onChangeCallback,
                validator: onValidateCallback,
                onSaved: onSavedCallback
              ),
            ),
          ),
        ],
      ),
    );
  }
}