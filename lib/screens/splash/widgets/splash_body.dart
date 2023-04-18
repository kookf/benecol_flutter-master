import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/material.dart';

import '../../home/home_screen.dart';

class SplashBody extends StatefulWidget {
  SplashBody({ Key? key }) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {

   SizeConfig sizeConfig = SizeConfig();


  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      _init(context);
    });

    Future.delayed(Duration(milliseconds: 1600), () {

      print("延时1秒执行");
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);


    });
  }

  Future<void> _init(BuildContext context) async {
    sizeConfig.init(context);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
      },
      child:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: sizeConfig.getScreenWidth > 740
                ? AssetImage('assets/images/splash/splash_background3_tablet.png')
                : AssetImage('assets/images/splash/splash_background31.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}