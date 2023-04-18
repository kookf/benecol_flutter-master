
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreSearchSelect extends StatelessWidget {
  String name;
  var onChange;
  String? value;
  int? _selected;
  String actionText;
  String placeholder;
  List<Map<String, dynamic>> options;

  StoreSearchSelect({
    Key? key,
    this.value,
    required this.name,
    required this.options,
    required this.onChange,
    required this.actionText,
    required this.placeholder,
  }) : super(key: key);

  void onSelectClick(BuildContext context){
    showSheet(
      context, 
      // onFocusChange: onFocusChange,
      child: SizedBox(
        height: 200,
        child: CupertinoPicker(
          scrollController: new FixedExtentScrollController(
            initialItem: (value != null)? options.indexWhere((option) => option['value'] == value) : 0,
          ),
          itemExtent: 36,
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
                    fontSize: 21
                  )
                )
              ),
            )
          ),
        )
      ), 
      actionText: actionText,
      onClicked: (){
        String _finalValue;
        if(_selected == null) {
          if(value == null){
            _finalValue = options[0]['value']!;
          }else{
            _finalValue = options.where((option) => option['value'] == value).toList()[0]['value'];
          }
        }else{
          _finalValue = options[_selected!]['value']!;
        }
        onChange(_finalValue);
        Navigator.pop(context);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          onSelectClick(context);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1, 
                color: getColorFromHex('#EEEEEE')
              ),
              left: BorderSide(
                width: 0.5, 
                color: getColorFromHex('#EEEEEE')
              ),
              right: BorderSide(
                width: 0.5, 
                color: getColorFromHex('#EEEEEE')
              ),
              bottom: BorderSide(
                width: 1, 
                color: getColorFromHex('#EEEEEE')
              )
            )
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 9
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  value ?? placeholder,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    color: (value != null) ? kSecondaryColor : getColorFromHex('#999999')
                  )
                ),
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: kSecondaryColor,
                  size: 20
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}