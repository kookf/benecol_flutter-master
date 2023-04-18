
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_address_select_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeAddressSelectInput extends StatefulWidget {
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
  final Color secondaryColor;
  final Map<String, dynamic>? initialValue;
  final Color? indicatorColor;
  final Color? placeholderColor;
  final EdgeInsets? inputPadding;
  final void Function(bool)? onFocusCallback;
  final void Function(Map<String, dynamic>?) onSavedCallback;
  final void Function(Map<String, dynamic>)? onChangeCallback;
  final String? Function(Map<String, dynamic>?) onValidateCallback;

  ExchangeAddressSelectInput({
    Key? key,
    this.style,
    this.format,
    this.remark,
    this.labelIcon,
    this.labelColor,
    this.placeholder,
    this.initialValue,
    this.inputPadding,
    this.indicatorColor,
    this.placeholderColor,
    this.onChangeCallback,
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
  _ExchangeAddressSelectInputState createState() => _ExchangeAddressSelectInputState();
}

class _ExchangeAddressSelectInputState extends State<ExchangeAddressSelectInput> {
  late FocusNode _focusNode;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  Map<String, dynamic>? _address;
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

  void onChangeCallback(Map<String, dynamic> address){
    if(widget.onChangeCallback != null){
      widget.onChangeCallback!(address);
    }
    setState(() {
      _address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _nodeAttachment.reparent();
    return Column(
      children: [
        Container(
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
                      padding: widget.inputPadding ?? EdgeInsets.symmetric(vertical: 8, horizontal: 5.0),
                      child: ExchangeAddressFormField(
                        //--------Required--------
                        context: context,
                        options: widget.options,
                        focusDetector: focusDetector,
                        onSaved: widget.onSavedCallback,
                        validator: widget.onValidateCallback,
                        //--------Optional--------
                        style: widget.style,
                        actionText: T.dialogConfirm,
                        placeholder: widget.placeholder,
                        initialValue: widget.initialValue,
                        indicatorColor: widget.indicatorColor,
                        placeholderColor: widget.placeholderColor,
                        onChangeCallback: onChangeCallback,
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
        ),
        if(_address != null)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // '收件人姓名: ${_address!['name']}\n'
                '${T.exchangeProductAddressSelectNamePrefix}${_address!['name']}\n'
                // '電話號碼: ${_address!['phone']}\n'
                '${T.exchangeProductAddressSelectAddressPrefix}${_address!['address']}\n'
                // '郵寄地址: ${_address!['address']}',
                '${T.exchangeProductAddressSelectPhonePrefix}${_address!['phone']}',
                style: TextStyle(
                  fontSize: 13
                )
              ),
            ],
          ),
        )
      ],
    );
  }
}