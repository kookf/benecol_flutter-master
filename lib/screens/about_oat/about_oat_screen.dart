import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/about_oat/widgets/about_oat_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutOatScreen extends StatelessWidget {
  AboutOatScreen({ Key? key }) : super(key: key);
  static final routeName = 'aboutOat';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kAppBarHeight,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            // '關於倍樂醇',
            T.aboutOatPageTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        endDrawer: AppDrawer(),
        body: AboutOatBody()
      ),
    );
  }
}