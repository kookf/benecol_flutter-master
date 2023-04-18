
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreSearchBtn extends StatelessWidget {
  VoidCallback onSearchBtnClick;

  StoreSearchBtn({
    Key? key,
    required this.onSearchBtnClick
  }) : super(key: key);
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        top: 30
      ),
      child: TextButton(
        onPressed: onSearchBtnClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // '尋找',
              T.storeSearchBtnText,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              )
            ),
          ],
        ),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: kSecondaryColor,
          padding: EdgeInsets.symmetric(
            vertical:10,
          ),
        ),
      ),
    );
  }
}
