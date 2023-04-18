import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/about/about_screen.dart';
import 'package:benecol_flutter/screens/about_oat/about_oat_screen.dart';
import 'package:benecol_flutter/screens/calculator/calculator_screen.dart';
import 'package:benecol_flutter/screens/health/health_screen.dart';
import 'package:benecol_flutter/screens/home/home_screen.dart';
import 'package:benecol_flutter/screens/instruction/instruction_screen.dart';
import 'package:benecol_flutter/screens/latest/latest_screen.dart';
import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/screens/profile/profile_screen.dart';
import 'package:benecol_flutter/screens/promotion/promotion_screen.dart';
import 'package:benecol_flutter/screens/reminder/reminder_screen.dart';
import 'package:benecol_flutter/screens/setting/setting_screen.dart';
import 'package:benecol_flutter/screens/store/store_screen.dart';
import 'package:benecol_flutter/services/myFirebase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isAuth = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      // int _currentId = getCurrentLangId(context);
      // await context.read<ContentProvider>().getInstructionDetail(context, _currentId.toString());
      bool isAuth = await context.read<AuthProvider>().isAuthenticated();
      setState(() {
        _isAuth = isAuth;
      });
    });
  }

  void unSubscribeFirebaseTopicAccordingToUser(){
    print('[Logout] unSubscribeFirebaseTopicAccordingToUser');
    if(context.read<AuthProvider>().isRegisteredFirebaseTestingTopic){
      MyFirebaseSingleton _myFirebase = new MyFirebaseSingleton();
      _myFirebase.unSubscribeTestingTopic();
      context.read<AuthProvider>().setIsRegisteredFirebasetestingTopic(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        children: [
          DrawerItem(
            iconImage: "assets/icons/menu_1.png",
            text: T.drawerHome,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
            },
          ),
          // 2022/08/14 Desc: Roll back oat button due to oat product failure
          // DrawerItem(
          //   iconImage: "assets/icons/about_oat.png",
          //   text: T.drawerAboutOat,
          //   press: (){
          //     Navigator.pushNamedAndRemoveUntil(context, AboutOatScreen.routeName, (route) => false);
          //   },
          // ),
          DrawerItem(
            iconImage: "assets/icons/money.png",
            text: T.drawerMembership,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, InstructionScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/news.png",
            text: T.drawerNews,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, LatestScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_7.png",
            text: T.drawerStore,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, StoreScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_4.png",
            text: T.drawerHealth,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, HealthScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_2.png",
            text: T.drawerAbout,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, AboutScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_6.png",
            text: T.drawerPromotion,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, PromotionScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_3.png",
            text: T.drawerCalculator,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, CalculatorScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_5.png",
            text: T.drawerReminder,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, ReminderScreen.routeName, (route) => false);
            },
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_8.png",
            text: T.drawerMyAccount,
            press: () async {
              bool isAuth = await context.read<AuthProvider>().isAuthenticated();
              Navigator.pushNamedAndRemoveUntil(
                context, 
                isAuth ? ProfileScreen.routeName : LoginScreen.routeName, 
                (route) => false
              );
            }
          ),
          DrawerItem(
            iconImage: "assets/icons/menu_9.png",
            text: T.drawerMore,
            press: (){
              Navigator.pushNamedAndRemoveUntil(context, SettingScreen.routeName, (route) => false);
            },
          ),
          if(_isAuth)
          DrawerItem(
            iconImage: "assets/icons/menu_10.png",
            text: T.drawerLogout,
            press: () async {
              await context.read<AuthProvider>().logout();
              context.read<UserProvider>().resetUserProfile();
              unSubscribeFirebaseTopicAccordingToUser();
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key, 
    required this.iconImage, 
    required this.text, 
    required this.press,
  }) : super(key: key);

  final String iconImage;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: ImageIcon(
        AssetImage(iconImage),
        color: kPrimaryColor,
        size: 22,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      horizontalTitleGap: 0,
      onTap: press,
    );
  }
}