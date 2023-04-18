
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomButton extends StatelessWidget {
  VoidCallback press;
  String buttonText;

  BottomButton({
    Key? key,
    required this.press,
    required this.buttonText
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Container(
      height: 45,
      width: double.infinity,
      padding: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
      ),
      child: TextButton(
        onPressed: press, 
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white
          )
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: kSecondaryColor)
          ),
          backgroundColor: kSecondaryColor,
          padding: EdgeInsets.symmetric(horizontal: 5),
          textStyle: TextStyle(
              fontSize: 12
          ),
        ),
      ),
    );
  }
}