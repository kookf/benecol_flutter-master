
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/address_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AddressCallback = void Function(Map<String, dynamic>);

class ExchangeAddressFormField extends FormField<Map<String, dynamic>>{
  ExchangeAddressFormField({
    required List<Map<String,String>> options,
    required BuildContext context,
    required VoidCallback focusDetector,
    required FormFieldSetter<Map<String, dynamic>> onSaved,
    required FormFieldValidator<Map<String, dynamic>> validator,
    TextStyle? style,
    String? actionText,
    String? placeholder,
    Function(bool)? onFocusChange,
    Function(Map<String, dynamic>)? onChangeCallback,
    Map<String, dynamic>? initialValue,
    Color? indicatorColor,
    Color? placeholderColor,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    autovalidateMode: AutovalidateMode.disabled,
    initialValue: initialValue,
    builder: (FormFieldState<Map<String, dynamic>> state){

      void onSelectAddressCallback(Map<String, dynamic> address){
        state.didChange(address);
        if(onChangeCallback != null){
          onChangeCallback(address);
        }
      }

      void showAddressListModal(BuildContext context){
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context) {
              return AddressList(
                onSelectAddressCallback: onSelectAddressCallback
              );
            },
            fullscreenDialog: true,
          ),
        );
      }

      return GestureDetector(
        onTap: (){
          focusDetector();
          showAddressListModal(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ((state.value.toString() == '' || state.value == null))
              ? Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(
                        placeholder ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: placeholderColor ?? Colors.white
                        )
                      )
                    ]
                  )
                )
              )
              : Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(
                        placeholder ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: style ?? TextStyle(color: kSecondaryColor)
                      )
                    ]
                  )
                )
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: indicatorColor ?? Colors.white,
                  size: 20
                ),
              )
            ],
          ),
        ),
      );
    }
  );
}