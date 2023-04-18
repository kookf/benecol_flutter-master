import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/promotion/widgets/promotion_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PromotionScreen extends StatelessWidget {
  PromotionScreen({ Key? key }) : super(key: key);
  static final routeName = 'Promotion';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '推廣展位',
          T.promotionPageTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      endDrawer: AppDrawer(),
      body: PromotionBody()
    );
  }
}