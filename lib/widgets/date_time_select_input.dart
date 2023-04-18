
import 'package:benecol_flutter/widgets/date_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateTimeSelectInput extends StatefulWidget {
  final String label;
  final bool focused;
  final TextStyle? style;
  final DateFormat? format;
  final Color? labelColor;
  final Widget? labelIcon;
  final Color primaryColor;
  final String? placeholder;
  final Function? onDismiss;
  final Color secondaryColor;
  final String? initialValue;
  final DateTime? minimumDate;
  final void Function(bool)? onFocusCallback;
  final void Function(String?) onSavedCallback;
  final void Function(String)? onChangeCallback;
  final String? Function(String?) onValidateCallback;

  DateTimeSelectInput({
    Key? key,
    this.style,
    this.format,
    this.labelIcon,
    this.onDismiss,
    this.labelColor,
    this.placeholder,
    this.minimumDate,
    this.initialValue,
    this.onChangeCallback,
    required this.label,
    required this.focused,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onFocusCallback,
    required this.onSavedCallback,
    required this.onValidateCallback,
  }) : super(key: key);

  @override
  _DateTimeSelectInputState createState() => _DateTimeSelectInputState();
}

class _DateTimeSelectInputState extends State<DateTimeSelectInput> {
  late FocusNode _focusNode;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  late AppLocalizations T;

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
    T = AppLocalizations.of(context)!;
    _nodeAttachment.reparent();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(widget.labelIcon != null) 
              widget.labelIcon!,
              Container(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 17,
                    color: widget.labelColor ?? widget.primaryColor
                  ),
                ),
                padding: EdgeInsets.only(right: 20)
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                  child: DateFormField(
                    //--------Required--------
                    context: context,
                    focusDetector: focusDetector,
                    onSaved: widget.onSavedCallback,
                    format: widget.format ?? DateFormat('yyyy-MM-dd'),
                    initialValue: widget.initialValue,
                    validator: widget.onValidateCallback,
                    //--------Optional--------
                    actionText: T.dialogConfirm,
                    style: widget.style,
                    placeholder: widget.placeholder,
                    maximumYear: DateTime.now().year,
                    minimumDate: widget.minimumDate,
                    mode: CupertinoDatePickerMode.date,
                    onChangeCallback: widget.onChangeCallback,
                  ),
                ),
              )
            ],
          ),
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