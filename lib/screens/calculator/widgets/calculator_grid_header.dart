
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorGridHeader extends StatelessWidget {
  CalculatorGridHeader({
    Key? key,
  }) : super(key: key);
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 3
      ),
      margin: EdgeInsets.only(
        top: 15,
      ),
      decoration: BoxDecoration(
        color: getColorFromHex('#f1eff1')
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.4,
            child: Text(
              // '食物',
              T.calculatorGridFoodHeader,
              style: TextStyle(
                fontSize: 12,
                color: getColorFromHex('#666666')
              )
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.4,
            child: Text(
              // '份量',
              T.calculatorGridPortionHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: getColorFromHex('#666666')
              )
            ),
          ),
          Flexible(
            child: Text(
              // '膽固醇含量(毫克)',
              T.calculatorGridCholesterolHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: getColorFromHex('#666666')
              )
            ),
          )
        ],
      ),
    );
  }
}
