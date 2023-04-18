import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/FAQ/widgets/faq_body.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({ Key? key }) : super(key: key);

  static String routeName = 'FAQScreen';

  Future<void> fetchFaqs(BuildContext context, int langId) async {
    EasyLoading.show();
    await context.read<SettingProvider>().fetchFAQ(langId);
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
          T.faqTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      body: FAQBody()      
    );
  }
}