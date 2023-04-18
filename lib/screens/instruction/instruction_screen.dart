import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/instruction/widgets/instruction_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstructionScreen extends StatelessWidget {
  InstructionScreen({ Key? key }) : super(key: key);
  static final routeName = 'instruction';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/instruction/bj.jpg'),
            fit: BoxFit.fitWidth
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kAppBarHeight,
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            title: Text(
              // '樂醇會會員計劃',
              T.instructionPageTitle,
              style: TextStyle(
                fontSize: kAppBarFontSize
              )
            ),
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          endDrawer: AppDrawer(),
          body: InstructionBody()
        ),
      ),
    );
  }
}