import 'dart:developer';

import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:benecol_flutter/providers/home_provider.dart';
import 'package:benecol_flutter/screens/home/widgets/home_banner.dart';
import 'package:benecol_flutter/screens/home/widgets/home_menu.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Body extends StatelessWidget {
  Body({ Key? key }) : super(key: key);
  String _registrationId = '';

  Future<void> fetchHomeBanner(BuildContext context, int langId) async {
    EasyLoading.show();
    await context.read<HomeProvider>().fetchHomeBanner(langId);
    EasyLoading.dismiss();
  }

  Future<void> fetchHomeAds(BuildContext context, int langId) async {
    bool _isShownHomeAds = context.read<HomeProvider>().isShownHomeAds;
    if(_isShownHomeAds) return;
    EasyLoading.show();
    String homeAdsImg = await context.read<HomeProvider>().fetchHomeAds(langId);
    EasyLoading.dismiss();
    if(homeAdsImg != ''){
      Navigator.push(context,
        PageRouteBuilder(
          opaque: false, // set to false
          transitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          pageBuilder: (_, __, ___) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              color: Colors.black.withOpacity(0.8),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Image.network(homeAdsImg),
                      Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: GestureDetector(
                          onTap: (){
                              Navigator.of(context).pop();
                          },
                          child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Colors.black.withOpacity(0.8),
                              child: Icon(Icons.close, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ]
              )
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String _registrationId = context.watch<AuthProvider>().registrationId;
    int langId = getCurrentLangId(context);
    fetchHomeAds(context, langId);
    fetchHomeBanner(context, langId);
    
    return WillPopScope( //Prevent android back action
      onWillPop: () async => false,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home/menubg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                HomeBanner(),
                // SizedBox(height: getPropScreenWidth(5)),
                HomeMenu(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
