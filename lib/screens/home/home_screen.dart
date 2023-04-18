import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/home/widgets/home_body.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  static String routeName = 'home';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor, // status bar color
        brightness: Brightness.light, // status bar brightness
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Body()
      ),
    );
  }
}