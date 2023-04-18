import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/login/forget_password/widgets/forget_password_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({ Key? key }) : super(key: key);

  static final routeName = 'forgetPassword';

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.forgetPasswordTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: ForgetPasswordBody()
    );
  }
}