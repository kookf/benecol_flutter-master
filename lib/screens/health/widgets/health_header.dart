
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HealthHeader extends StatelessWidget {
  String activeTab;
  Function onTabClick;
  late AppLocalizations T;

  HealthHeader({
    Key? key,
    required this.activeTab,
    required this.onTabClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              onTabClick('news');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6
              ),
              color: (activeTab == 'news') ? kSecondaryColor : kPrimaryLightColor,
              child: Center(
                child: Text(
                  // '新聞',
                  T.healthHeaderNewTxt,
                  style: TextStyle(
                    color: (activeTab == 'news') ? Colors.white : getColorFromHex('#b3b1b3')
                  )
                ),
              ),
            ),
          )
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              onTabClick('tips');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6
              ),
              color: (activeTab == 'tips') ? kSecondaryColor : kPrimaryLightColor,
              child: Center(
                child: Text(
                  // '健康貼士',
                  T.healthHeaderTipsTxt,
                  style: TextStyle(
                    color: (activeTab == 'tips') ? Colors.white : getColorFromHex('#b3b1b3')
                  )
                ),
              ),
            ),
          )
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              onTabClick('chols');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6
              ),
              color: (activeTab == 'chols') ? kSecondaryColor : kPrimaryLightColor,
              child: Center(
                child: Text(
                  // '膽固醇',
                  T.healthHeaderCholTxt,
                  style: TextStyle(
                    color: (activeTab == 'chols') ? Colors.white : getColorFromHex('#b3b1b3')
                  )
                ),
              ),
            ),
          )
        ),
      ],
    );
  }
}
