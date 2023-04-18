import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/screens/splash/widgets/splash_body.dart';
import 'package:benecol_flutter/services/myFirebase.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/screens/home/home_screen.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:benecol_flutter/services/notificationService.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:benecol_flutter/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:store_redirect/store_redirect.dart'; 

/* Top-level function for handling background notification */
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class SplashScreen extends StatefulWidget {
  SplashScreen({ Key? key }) : super(key: key);
  static String routeName = 'splash';
  // final SizeConfig sizeConfig = SizeConfig();
  bool isSetScreenWidthHeight = false;
  late MyFirebaseSingleton _myFirebase;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SizeConfig? sizeConfig;


  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero).then((value) async{
      sizeConfig = SizeConfig();
      sizeConfig!.init(context);
      _init(context);
    });
  }

  Future<void> _init(BuildContext context) async {
    await NotificationService.init(context);
    widget._myFirebase = new MyFirebaseSingleton();
    await widget._myFirebase.init();
    widget._myFirebase.subscribeTopic(env);
    widget._myFirebase.registerBackgroundHandle(_firebaseMessagingBackgroundHandler);
    await initLang(context);
    await checkAppMinimumVersion(context);
  }

  checkAppMinimumVersion(BuildContext context) async{
    AppLocalizations T = AppLocalizations.of(context)!;
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    String _appName = _packageInfo.appName;
    String _packageName = _packageInfo.packageName;
    String _version = _packageInfo.version;
    String _buildNumber = _packageInfo.buildNumber;
    
    await context.read<SettingProvider>().getAppMinimumVersion();
    int? _minVersion = await context.read<SettingProvider>().appMinVersion;
    if(_minVersion == null || _minVersion > int.parse(_buildNumber)){
      showAlertDialogWithOnlyConfirm(
        context,
        title: T.forceUpdateMessage,
        actionText: T.forceUpdateActionMessage,
        action: (){
          StoreRedirect.redirect(
            androidAppId: "app.benecol.benecolapp",
            iOSAppId: "925970802"
          );
        }
      );
    }else{
      // Continue
      // Timer(Duration(seconds:1), (){
      //   Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
      // });
      goNextCheck(context);
    }
  }

  initLang(BuildContext context) async {
    LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
    String? _presetLang = await _localStorageSingleton.getValue('lang');
    if(_presetLang != null){
      // print('Found preset Lang: $_presetLang');
      Locale _presetLocale;
      if(_presetLang=='zh_Hant'){
        _presetLocale = Locale('zh', 'Hant'); //need special handle for zh_Hant
      }else{
        _presetLocale = Locale(_presetLang);
      }
      // Locale _presetLocale = Locale(_presetLang);
      context.read<LocaleProvider>().setLocale(_presetLocale);
    }
  }

  goNextCheck(BuildContext context){
    if(widget.isSetScreenWidthHeight){
      Timer(Duration(seconds:1), (){
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
      });
    }else{
      checkNonZeroWidhtHeight(context);
    }
  }

  void checkNonZeroWidhtHeight(BuildContext context){
    double _screenWidth = sizeConfig!.getScreenWidth;
    double _screenHeight = sizeConfig!.getScreenHeight;
    if(_screenWidth == 0 || _screenHeight == 0){
      sizeConfig!.init(context);
      Timer(Duration(seconds:1), (){
        goNextCheck(context);
      });
    }else{
      setState(() {
        widget.isSetScreenWidthHeight = false;
      });
      goNextCheck(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SplashBody(),
    );
  }
}