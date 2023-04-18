
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomButton extends StatelessWidget {
  BottomButton({
    Key? key,
    required this.press
  }) : super(key: key);

  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Container(
      height: 80,
      width: double.infinity,
      // padding: EdgeInsets.symmetric(vertical: getPropScreenWidth(18)),
      padding: EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
      ),
      child: TextButton(
        onPressed: press, 
        child: Text(
          T.emailUsSendButtonText,
          style: TextStyle(
            // fontSize: getPropScreenWidth(16),
            fontSize: 16,
            fontWeight: FontWeight.w200,
            color: kSecondaryColor
          )
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: kSecondaryColor)
            )
          )
        )
      ),
    );
  }
}