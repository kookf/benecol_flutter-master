
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorHeader extends StatelessWidget {
  String activeTap;
  Function onTapClick;

  CalculatorHeader({
    Key? key,
    required this.activeTap,
    required this.onTapClick
  }) : super(key: key);
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              onTapClick('calculator');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6
              ),
              // color: kSecondaryColor,
              color: (activeTap == 'calculator') ? kSecondaryColor : kPrimaryLightColor,
              child: Center(
                child: Text(
                  // '攝取量計算',
                  T.calculatorSegmentCalculateTxt,
                  style: TextStyle(
                    // color: Colors.white
                    color: (activeTap == 'calculator') ? Colors.white : getColorFromHex('#b3b1b3')
                  )
                ),
              ),
            ),
          )
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              onTapClick('record');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6
              ),
              // color: kPrimaryLightColor,
              color: (activeTap == 'record') ? kSecondaryColor : kPrimaryLightColor,
              child: Center(
                child: Text(
                  // '記錄',
                  T.calculatorSegmentRecordTxt,
                  style: TextStyle(
                    // color: getColorFromHex('#b3b1b3')
                    color: (activeTap == 'record') ? Colors.white : getColorFromHex('#b3b1b3')
                  )
                ),
              ),
            ),
          )
        )
      ],
    );
  }
}
