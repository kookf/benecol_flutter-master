
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotifyDialog extends StatelessWidget {
  NotifyDialog({
    Key? key,
  }) : super(key: key);

  Color borderColor = getColorFromHex('#d9d9d9');
  // double titleFontSize = getPropScreenWidth(16);
  // double contentFontSize = getPropScreenWidth(13);
  // double actionFontSize = getPropScreenWidth(16);
  double titleFontSize = 16;
  double contentFontSize = 13;
  double actionFontSize = 16;

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return SimpleDialog(
      title: Center(
        child: Text(
          T.notifyDialogTitle,
          style: TextStyle(
            fontSize: titleFontSize
          )
        )
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.13
      ),
      contentPadding: EdgeInsets.zero,
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5, color: borderColor))
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 15),
                child: Center(
                  child: Text(
                    T.notifyDialogContent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: contentFontSize
                    )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)
                  )
                ),
                child: Center(
                  child: Text(
                    T.notifyDialogAction,
                    style: TextStyle(
                      fontSize: actionFontSize,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    )
                  ),
                )
              ),
            )
          ],
        )
      ],
    );
  }
}