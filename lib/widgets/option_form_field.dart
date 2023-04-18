
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionFormField extends FormField<String>{
  OptionFormField({
    required List<Map<String,String>> options,
    required BuildContext context,
    required VoidCallback focusDetector,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextStyle? style,
    String? actionText,
    String? placeholder,
    GlobalKey<FormFieldState<String>>? CustomKey,
    Function(bool)? onFocusChange,
    Function(String)? onChangeCallback,
    String? initialValue,
    Color? indicatorColor,
    Color? placeholderColor,
    double? pickerItemHeight,
    EdgeInsets? inputPadding,
    double? pickerItemFontSize,
  }) : super(
    key: CustomKey,
    onSaved: onSaved,
    validator: validator,
    autovalidateMode: AutovalidateMode.disabled,
    initialValue: initialValue,
    builder: (FormFieldState<String> state){
      int? _selected = options.indexWhere(
        (option) => option['value'] == state.value
      );

      // state.reset();
      
      return GestureDetector(
        onTap: (){
          focusDetector();
          showSheet(
            context, 
            onFocusChange: onFocusChange,
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController: new FixedExtentScrollController(
                  initialItem: _selected ?? (_selected! > -1 ? _selected! : 0),
                ),
                itemExtent: pickerItemHeight ?? 36, //36
                onSelectedItemChanged: (index){
                  _selected = index;
                },
                children: List.generate(
                  options.length, 
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15
                    ),
                    child: Center(
                      child: Text(
                        options[index]['text']!,
                        style: TextStyle(
                          fontSize: pickerItemFontSize ?? 21
                        )
                      )
                    ),
                  )
                ),
              )
            ), 
            actionText: actionText ?? 'Confirm',
            onClicked: (){
              if(_selected == null) return; 
              state.didChange(options[_selected!]['value']);
              if(onFocusChange != null){
                onFocusChange(false);
              }
              if(onChangeCallback != null){
                onChangeCallback(options[_selected!]['value']!);
              }
              Navigator.pop(context);
            }
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent
          ),
          padding: inputPadding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ((state.value.toString() == '' || state.value == null))
              ? Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        placeholder ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: placeholderColor ?? Colors.white
                        )
                      ),
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
                        '${options[_selected!]['text']}',
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
