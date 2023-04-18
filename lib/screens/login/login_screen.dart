import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/login/widgets/login_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  static final routeName = 'login';

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    final args = ModalRoute.of(context)!.settings.arguments;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kAppBarHeight,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            T.loginTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
          elevation: 0,
        ),
        backgroundColor: kPrimaryColor,
        endDrawer: AppDrawer(),
        body: LoginBody(
          args: args
        )
      ),
    );
  }
}