
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:benecol_flutter/providers/locale_provider.dart';
import 'package:benecol_flutter/screens/about/about_screen.dart';
import 'package:benecol_flutter/screens/about_oat/about_oat_screen.dart';
import 'package:benecol_flutter/screens/calculator/calculator_screen.dart';
import 'package:benecol_flutter/screens/health/health_screen.dart';
import 'package:benecol_flutter/screens/instruction/instruction_screen.dart';
import 'package:benecol_flutter/screens/latest/latest_screen.dart';
import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/screens/profile/profile_screen.dart';
import 'package:benecol_flutter/screens/promotion/promotion_screen.dart';
import 'package:benecol_flutter/screens/reminder/reminder_screen.dart';
import 'package:benecol_flutter/screens/setting/setting_screen.dart';
import 'package:benecol_flutter/screens/store/store_screen.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lang = context.read<LocaleProvider>().locale?.toString() ?? Localizations.localeOf(context).toString();

    return Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 15,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getPropScreenWidth(9)),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 3,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, InstructionScreen.routeName, (route) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_01.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getPropScreenWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getPropScreenWidth(10)),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamed(context, LatestScreen.routeName);
                        },
                        image: 'assets/images/home/$lang/menu_btn_02.png',
                      ),
                    )
                  ),
                  // 2022/08/14 Desc: Roll back oat button due to oat product failure
                  // Expanded(
                  //   child: AspectRatio(
                  //     aspectRatio: 1,
                  //     child: MenuButton(
                  //       press: (){
                  //         Navigator.pushNamed(context, AboutOatScreen.routeName);
                  //       },
                  //       image: 'assets/images/home/$lang/menu_btn_02_new.png',
                  //     ),
                  //   )
                  // ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, StoreScreen.routeName, (route) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_03.png',
                      ),
                    )
                  ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, HealthScreen.routeName, (route) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_04.png',
                      ),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: getPropScreenWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getPropScreenWidth(10)),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, AboutScreen.routeName, (route) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_05.png',
                      ),
                    )
                  ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: () async {
                          bool isAuth = await context.read<AuthProvider>().isAuthenticated();
                          Navigator.pushNamedAndRemoveUntil(
                            context, 
                            isAuth ? PromotionScreen.routeName : LoginScreen.routeName, 
                            (route) => false,
                            arguments: (isAuth) ? null
                            : PromotionScreen.routeName
                          );
                          // Navigator.pushNamedAndRemoveUntil(context, PromotionScreen.routeName, (route) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_06.png',
                      ),
                    )
                  ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, CalculatorScreen.routeName, (_) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_07.png',
                      ),
                    )
                  ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, ReminderScreen.routeName, (_) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_08.png',
                      ),
                    )
                  ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: () async {
                          bool isAuth = await context.read<AuthProvider>().isAuthenticated();
                          Navigator.pushNamedAndRemoveUntil(
                            context, 
                            isAuth ? ProfileScreen.routeName : LoginScreen.routeName, 
                            (route) => false
                          );
                          // Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (_) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_09.png',
                      ),
                    )
                  ),
                  SizedBox(width: getPropScreenWidth(10)),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MenuButton(
                        press: (){
                          Navigator.pushNamedAndRemoveUntil(context, SettingScreen.routeName, (_) => false);
                        },
                        image: 'assets/images/home/$lang/menu_btn_10.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.press,
    required this.image,
  }) : super(key: key);

  final VoidCallback press;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
