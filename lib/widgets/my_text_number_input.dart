
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextNumberInput extends StatelessWidget {
  // obscureText: true,
  // enableSuggestions: false,
  // autocorrect: false,

  final bool isLimit;
  final bool focused;
  final String label;
  final Color primaryColor;
  final TextInputType type;
  final Color secondaryColor;
  final Key? key;
  final bool? enable;
  final String? remark;
  final bool? obscureText;
  final bool? autocorrect;
  final Color? labelColor;
  final Widget? labelIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool? enableSuggestions;
  final EdgeInsets? inputPadding;
  final TextEditingController? controller;
  final void Function(bool) onFocusCallback;
  final void Function(String? newValue) onSavedCallback;
  final String? Function(String? value) onChangeCallback;
  final String? Function(String? value) onValidateCallback;

  MyTextNumberInput({
    this.key,
    this.enable,
    this.remark,
    this.labelIcon,
    this.suffixIcon,
    this.controller,
    this.labelColor,
    this.obscureText,
    this.autocorrect,
    this.initialValue,
    this.inputPadding,
    this.enableSuggestions,
    this.isLimit = false,
    required this.type,
    required this.label,
    required this.focused,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onFocusCallback,
    required this.onSavedCallback,
    required this.onChangeCallback,
    required this.onValidateCallback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Row(
              children: [
                if(labelIcon != null)
                  labelIcon!,
                Container(
                    child: Text(
                      label,
                      style: TextStyle(
                          fontSize: 17,
                          color: labelColor ?? primaryColor
                      ),
                    ),
                    padding: EdgeInsets.only(right: 20)
                ),
                Expanded(
                  child: Focus(
                    onFocusChange: onFocusCallback,
                    autofocus: false,
                    canRequestFocus: false,
                    child: TextFormField(
                      key: key,
                      enabled: enable ?? true,
                      keyboardType: type,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),

                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: inputPadding ?? EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                        errorStyle: TextStyle(height: 0),
                        isDense: true,
                      ),
                      style: TextStyle(
                        fontSize: 17,
                        color: secondaryColor,
                      ),
                      controller: controller,
                      textAlign: TextAlign.end,
                      initialValue: initialValue,
                      cursorColor: secondaryColor,
                      onSaved: onSavedCallback,
                      onChanged: onChangeCallback,
                      validator: onValidateCallback,
                      obscureText: obscureText ?? false,
                      autocorrect: autocorrect ?? true,
                      enableSuggestions: enableSuggestions ?? true,
                    ),
                  ),
                ),
                if(suffixIcon != null)
                  suffixIcon!,
              ],
            ),
            if(remark != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 15,
                    bottom: 5
                ),
                child: Text(
                    '$remark',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12
                    )
                ),
              ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: focused ? secondaryColor : primaryColor
                )
            )
        )
    );
  }
}