import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/reminder/widgets/reminder_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({ Key? key }) : super(key: key);
  static final routeName = 'Reminder';
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
            // '飲用提醒',
            T.reminderPageTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
          elevation: 0,
        ),
        backgroundColor: kSecondaryColor,
        endDrawer: AppDrawer(),
        body: ReminderBody()
      ),
    );
  }
}