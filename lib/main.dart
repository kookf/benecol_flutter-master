import 'package:benecol_flutter/providers/about_oat_provider.dart';
import 'package:benecol_flutter/providers/about_provider.dart';
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/providers/exchange_provider.dart';
import 'package:benecol_flutter/providers/health_provider.dart';
import 'package:benecol_flutter/providers/store_provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/providers/home_provider.dart';
import 'package:benecol_flutter/providers/locale_provider.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/util/routes.dart';
import 'package:benecol_flutter/screens/splash/splash_screen.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/config.dart';
import 'l10n/l10n.dart';

void main() {
  setCustomErrorPage();

  lockDevicePortrait();
  runApp(MyApp());

  configLoading();
}

void lockDevicePortrait(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

void configLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = kPrimaryColor
    ..textColor = Colors.black
    ..userInteractions = false
    ..dismissOnTap = false;
}
void setCustomErrorPage() {

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return Container(
      color: Colors.white,
      child: const CupertinoActivityIndicator(),
    );
  };
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => ExchangeProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => HealthProvider()),
        ChangeNotifierProvider(create: (_) => AboutProvider()),
        ChangeNotifierProvider(create: (_) => AboutOatProvider())
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) {
          return MaterialApp(
            title: 'Benecol App',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            theme: ThemeData(
              // primaryColor: kPrimaryColor,
              // accentColor: kPrimaryLightColor,
              // primarySwatch: MaterialColor(kPrimaryColor),
              // primaryTextTheme: TextTheme(
              //   headline6: TextStyle(
              //     color: Colors.white
              //   )
              // )
            ),
            home: SplashScreen(),
            routes: routes,
            locale: provider.locale,
            // initialRoute: SplashScreen.routeName,
            // builder: EasyLoading.init(),
            builder: (context, Widget){
              Widget = EasyLoading.init()(context,Widget);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Widget,
              );
            },
          );
        }
      ),
    );
  }
}
