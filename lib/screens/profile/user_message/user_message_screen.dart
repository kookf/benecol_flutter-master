import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/user_message/widgets/user_message_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserMessageScreen extends StatelessWidget {
  UserMessageScreen({ Key? key }) : super(key: key);
  static final routeName = 'user_message';
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
          // '會員訊息',
          T.userMessageTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: UserMessageBody()
    );
  }
}