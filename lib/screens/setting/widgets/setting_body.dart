import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/locale_provider.dart';
import 'package:benecol_flutter/screens/setting/FAQ/faq_screen.dart';
import 'package:benecol_flutter/screens/setting/email/email_screen.dart';
import 'package:benecol_flutter/screens/setting/legal_notice/legal_notice_screen.dart';
import 'package:benecol_flutter/screens/setting/privacy/privacy_screen.dart';
import 'package:benecol_flutter/screens/setting/widgets/change_language_dialog.dart';
import 'package:benecol_flutter/screens/setting/widgets/general_row_with_icon.dart';
import 'package:benecol_flutter/screens/setting/widgets/notify_dialog.dart';
import 'package:benecol_flutter/screens/setting/widgets/set_language_row.dart';
import 'package:benecol_flutter/screens/setting/widgets/set_notify_row.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:benecol_flutter/services/localStorage.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({ Key? key }) : super(key: key);

  // ignore: non_constant_identifier_names
  static final TextStyle PRIMARY_TEXT_STYLE = TextStyle(
    color: kPrimaryColor,
    // fontSize: getPropScreenWidth(16),
    fontSize: 16,
    fontWeight: FontWeight.w500
  );
  // ignore: non_constant_identifier_names
  static final TextStyle SECONDARY_TEXT_STYLE = TextStyle(
    color: kSecondaryColor,
    // fontSize: getPropScreenWidth(16),
    fontSize: 16,
    fontWeight: FontWeight.w400
  );

  // Future<void> checkNotificationPermission() async {
  //   var status = await Permission.notification.status;
  //   print('status: $status');
  // }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;

    //get notification setting
    // checkNotificationPermission();

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getPropScreenWidth(15)),
          child: Column(
            children: [
              SizedBox(height: 18),
              SetLanguageRow(
                press: setLanguageCallback(context)
              ),
              SizedBox(height: 18),
              SetNotifyRow(
                press: setNotificationCallback(context)
              ),
              SizedBox(height: 18),
              GeneralRowWithIcon(
                text: T.faqTitle,
                image: "assets/icons/more_1.png",
                press: (){
                  Navigator.pushNamed(context, FAQScreen.routeName);
                } 
              ),
              SizedBox(height: 18),
              GeneralRowWithIcon(
                text: T.privacyPolicyTitle,
                image: "assets/icons/more_2.png",
                press: (){
                  Navigator.pushNamed(context, PrivacyScreen.routeName);
                } 
              ),
              SizedBox(height: 18),
              GeneralRowWithIcon(
                text: T.legalNoticeTitle,
                image: "assets/icons/more_2.png",
                press: (){
                  Navigator.pushNamed(context, LegalNoticeScreen.routeName);
                } 
              ),
              SizedBox(height: 18),
              GeneralRowWithIcon(
                text: T.emailUsTitle,
                image: "assets/icons/more_4.png",
                press: (){
                  Navigator.pushNamed(context, EmailScreen.routeName);
                } 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

VoidCallback setLanguageCallback(BuildContext context){
  LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
  Future<String?> changeLanguage(context) async {
    String? lang = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeLanguageDialog();
        });

    return lang;
  }
  
  return () async {
    String? newLang = await changeLanguage(context);
    if(newLang != null){
      Locale newLocale;
      if(newLang=='zh_Hant'){
        newLocale = Locale('zh', 'Hant'); //need special handle for zh_Hant
      }else{
        newLocale = Locale(newLang);
      }
      EasyLoading.show();
      Future.delayed(const Duration(milliseconds: 200), () async { //Ensure dialog close animation finished
        context.read<LocaleProvider>().setLocale(newLocale);
        await _localStorageSingleton.setValue('lang', newLocale.toString());
        EasyLoading.dismiss();
      });
    }
  };
}

VoidCallback setNotificationCallback(BuildContext context){
  Future<void> showNotificationPopup(context) async{
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return NotifyDialog();
      }
    );
  }

  return () async {
    showNotificationPopup(context);
  };
}
