import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/widgets/setting_body.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({ Key? key }) : super(key: key);
  static String routeName = 'setting';

  void getNotificationStatus(BuildContext context){
    context.read<SettingProvider>().getNotificationStatus();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    getNotificationStatus(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.settingTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      endDrawer: AppDrawer(),
      body: SettingBody(),
    );
  }
}

