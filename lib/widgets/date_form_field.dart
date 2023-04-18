
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends FormField<String>{
  DateFormField({
    required initialValue,
    required DateFormat format,
    required BuildContext context,
    required VoidCallback focusDetector,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    int? maximumYear,
    TextStyle? style,
    String? actionText,
    String? placeholder,
    DateTime? minimumDate,
    CupertinoDatePickerMode? mode,
    Function(bool)? onFocusChange,
    Function(String)? onChangeCallback,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidateMode: AutovalidateMode.disabled,
    builder: (FormFieldState<String> state){
      DateTime? _selectedDateTime;
      DateTime? _initialDateTime;
      void initializeSelectedDateTime(){
        try{
          _selectedDateTime = DateTime.parse(state.value.toString());
        }catch(e){
          _selectedDateTime = DateTime.now();
        }
      }
      void initializeinitialDateTime(){
        try{
          _initialDateTime = DateTime.parse(initialValue);
        }catch(e){
          _initialDateTime = DateTime.now();
        }
      }
      void resetStateValue(){
        state.reset();
      }

      initializeSelectedDateTime();
      initializeinitialDateTime();
      return GestureDetector(
        onTap: (){
          focusDetector();
          showSheet(
            context, 
            onFocusChange: onFocusChange,
            onDismiss: (){
              resetStateValue();
            },
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: _selectedDateTime ?? _initialDateTime ?? DateTime.now(),
                maximumYear: maximumYear,
                minimumDate: minimumDate,
                mode: mode ?? CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime){
                  _selectedDateTime = dateTime;
                }
              )
            ), 
            actionText: actionText ?? 'Confirm',
            onClicked: (){
              if(_selectedDateTime == null) return;
              String _dateTimeStr = format.format(_selectedDateTime!);
              state.didChange(_dateTimeStr);
              if(onFocusChange != null){
                onFocusChange(false);
              }
              if(onChangeCallback != null){
                onChangeCallback(_dateTimeStr);
              }
              Navigator.pop(context);
            }
          );
        },
        child: Text(
          (placeholder != null && state.value.toString() == '')
          ? placeholder 
          : '${state.value.toString()}',
          textAlign: TextAlign.end,
          style: style ?? TextStyle(color: kSecondaryColor)
        ),
      );
    }
  );
}
