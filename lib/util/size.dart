import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  double get getScreenWidth => screenWidth;
  double get getScreenHeight => screenHeight;

  void showStats(){
    print('_mediaQueryData: $_mediaQueryData');
    print('screenWidth: $screenWidth');
    print('screenHeight: $screenHeight');
    print('orientation: $orientation');
  }
}

double getPropScreenHeight(double inputHeight){ /** getProportionateScreenHeight */
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double getPropScreenWidth(double inputWidth){ /** getProportionateScreenWidth */
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}