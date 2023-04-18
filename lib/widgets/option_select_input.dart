
import 'package:benecol_flutter/widgets/option_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OptionSelectInput extends StatefulWidget {
  final String label;
  final bool focused;
  final List<Map<String,String>> options;
  final String? remark;
  final TextStyle? style;
  final Color? labelColor;
  final Widget? labelIcon;
  final DateFormat? format;
  final Color primaryColor;
  final String? placeholder;
  final GlobalKey<FormFieldState<String>>? CustomKey;
  final Color secondaryColor;
  final String? initialValue;
  final Color? indicatorColor;
  final Color? placeholderColor;
  final EdgeInsets? inputPadding;
  final double? pickerItemHeight;
  final double? pickerItemFontSize;

  final void Function(bool)? onFocusCallback;
  final void Function(String?) onSavedCallback;
  final void Function(String)? onChangeCallback;
  final String? Function(String?) onValidateCallback;

  OptionSelectInput({
    Key? key,
    this.style,
    this.format,
    this.remark,
    this.labelIcon,
    this.CustomKey,
    this.labelColor,
    this.placeholder,
    this.initialValue,
    this.inputPadding,
    this.indicatorColor,
    this.placeholderColor,
    this.onChangeCallback,
    this.pickerItemHeight,
    this.pickerItemFontSize,
    required this.label,
    required this.focused,
    required this.options,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onFocusCallback,
    required this.onSavedCallback,
    required this.onValidateCallback,
  }) : super(key: key);

  @override
  _OptionSelectInputState createState() => _OptionSelectInputState();
}

class _OptionSelectInputState extends State<OptionSelectInput> {
  late FocusNode _focusNode;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;

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
    AppLocalizations T = AppLocalizations.of(context)!;
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
                  decoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                  child: OptionFormField(
                    //--------Required--------
                    context: context,
                    options: widget.options,
                    focusDetector: focusDetector,
                    onSaved: widget.onSavedCallback,
                    validator: widget.onValidateCallback,
                    //--------Optional--------
                    style: widget.style,
                    actionText: T.dialogConfirm,
                    CustomKey: widget.CustomKey,
                    placeholder: widget.placeholder,
                    initialValue: widget.initialValue,
                    inputPadding: widget.inputPadding,
                    indicatorColor: widget.indicatorColor,
                    placeholderColor: widget.placeholderColor,
                    onChangeCallback: widget.onChangeCallback,
                    pickerItemHeight: widget.pickerItemHeight,
                    pickerItemFontSize: widget.pickerItemFontSize,
                  ),
                ),
              )
            ],
          ),
          if(widget.remark != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 15,
              bottom: 5
            ),
            child: Text(
              '${widget.remark}',
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
            color: widget.focused 
            ? widget.secondaryColor 
            : widget.primaryColor
          )
        )
      )
    );
  }
}