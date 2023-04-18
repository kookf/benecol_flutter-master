
import 'package:benecol_flutter/models/food.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';

class CalculatorGridRow extends StatelessWidget {
  Food food;
  VoidCallback onAddClick;
  VoidCallback onMinusClick;
  VoidCallback onSelectClick;

  CalculatorGridRow({
    Key? key,
    required this.food,
    required this.onAddClick,
    required this.onMinusClick,
    required this.onSelectClick
  }) : super(key: key);

  Color btnColor = getColorFromHex('#777777');
  Color selectedBtnColor = getColorFromHex('#e1002b');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.screenWidth*0.4,
            padding: EdgeInsets.symmetric(
              horizontal: 5
            ),
            child: Text(
              food.food,
              style: TextStyle(
                fontSize: 18
              )
            ),
          ),
          GestureDetector(
            onTap: onMinusClick,
            child: Container(
              width: SizeConfig.screenWidth*0.1,
              child: Icon(
                (food.accQty > food.qty)
                ? Icons.remove_circle 
                : Icons.remove_circle_outline, 
                color: btnColor
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth*0.2,
            child: Center(
              child: Text(
                '${food.accQty.round()} ${food.unit} ${food.unitExtra}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: onAddClick,
            child: Container(
              width: SizeConfig.screenWidth*0.1,
              child: Icon(
                (food.accQty/food.qty < 10)
                ? Icons.add_circle 
                : Icons.add_circle_outline, 
                color: btnColor
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth*0.1,
            child: Center(
              child: Text(
                '${((food.accQty/food.qty)*food.chol).round()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: onSelectClick,
            child: Container(
              width: SizeConfig.screenWidth*0.1,
              child: Icon(
                (food.isChecked)
                ? Icons.check_circle
                : Icons.check_circle_outline, 
                color: (food.isChecked) 
                ? selectedBtnColor
                : btnColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
