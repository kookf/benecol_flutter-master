
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionFormField extends FormField<String>{
  OptionFormField({
    required List<String> options,
    required BuildContext context,
    required VoidCallback focusDetector,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextStyle? style,
    String? actionText,
    String? placeholder,
    Function(bool)? onFocusChange,
    Function(String)? onChangeCallback,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    autovalidateMode: AutovalidateMode.disabled,
    builder: (FormFieldState<String> state){
      int? _selected = options.indexOf(state.value??'');

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
                  initialItem: _selected ?? 0,
                ),
                itemExtent: 36,
                onSelectedItemChanged: (index){
                  _selected = index;
                },
                children: List.generate(
                  options.length, 
                  (index) => Center(
                    child: Text(
                      options[index],
                    )
                  )
                ),
              )
            ), 
            actionText: actionText ?? 'Confirm',
            onClicked: (){
              if(_selected == null) return; 
              state.didChange(options[_selected!]);
              if(onFocusChange != null){
                onFocusChange(false);
              }
              if(onChangeCallback != null){
                onChangeCallback(options[_selected!]);
              }
              Navigator.pop(context);
            }
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (placeholder != null && (state.value.toString() == '' || state.value == null)) 
            ? Text(
              placeholder,
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.white)
            )
            : Text(
              '${state.value.toString()}',
              textAlign: TextAlign.end,
              style: style ?? TextStyle(color: kSecondaryColor)
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.white,
                size: 20
              ),
            )
          ],
        ),
      );
    }
  );
}
