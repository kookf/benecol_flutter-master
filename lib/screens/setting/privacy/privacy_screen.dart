import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/privacy/widgets/privacy_body.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({ Key? key }) : super(key: key);

  static final routeName = 'privacy';

  Future<void> fetchFaqs(BuildContext context, int langId) async {
    EasyLoading.show();
    await context.read<SettingProvider>().fetchPrivacy(langId);
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    int langId = getCurrentLangId(context);
    fetchFaqs(context, langId);
    AppLocalizations T = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.privacyPolicyTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      body: PrivacyBody(),
    );
  }
}