import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/legal_notice/widgets/legal_notice_body.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({ Key? key }) : super(key: key);

  static final routeName = 'legalNotice';

  Future<void> fetchLegalNotice(BuildContext context, int langId) async {
    EasyLoading.show();
    await context.read<SettingProvider>().fetchLegalNotice(langId);
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    int langId = getCurrentLangId(context);
    fetchLegalNotice(context, langId);
    AppLocalizations T = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.legalNoticeTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      body: LegalNoticeBody()
    );
  }
}