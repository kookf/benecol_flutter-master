import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/setting/email/widgets/email_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({ Key? key }) : super(key: key);

  static final routeName = 'email';

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.emailUsTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize,
          )
        ),
        elevation: 0,
      ),
      body: EmailBody(),
    );
  }
}