import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({ Key? key }) : super(key: key);
  static final routeName = 'Calculator';
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
            // '簡易膽固醇攝取計算',
            T.calculatorPageTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        endDrawer: AppDrawer(),
        body: CalculatorBody()
      ),
    );
  }
}