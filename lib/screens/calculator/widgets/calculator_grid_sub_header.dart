
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';

class CalculatorGridSubHeader extends StatelessWidget {
  const CalculatorGridSubHeader({
    Key? key,
    required String? selectedFoodTypeStr,
  }) : _selectedFoodTypeStr = selectedFoodTypeStr, super(key: key);

  final String? _selectedFoodTypeStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryColor
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5
      ),
      child: Center(
        child: Text(
          _selectedFoodTypeStr ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        )
      ),
    );
  }
}
