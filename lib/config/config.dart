import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';

/// Api Config
final urls = {
  "DEV" : "http://localhost:8000/api/",
  "SIT" : "http://benecol.hksay.com/api/",
  "UAT" : "http://benecol.hksay.com/api/",
  "PROD" : "http://newapps.benecolapps.com/api/",
  "TEST" : "http://benecolapp.ctrlf.hk/api/"
};


final env = 'PROD';

final apiUrl = urls[env]!;

/// Lang Config
final lang2Id = {
  "en": 1,
  "zh_Hant": 2
};

final id2Lang = {
  1: "en",
  2: "zh_Hant"
};

int getLangId(String langCode){
  return lang2Id[langCode]!;
}

String getLangCode(int langId){
  return id2Lang[langId]!;
}

/// Color Config 
final kPrimaryColor = getColorFromHex('#019BAC');
final kPrimaryLightColor = getColorFromHex('#F4F4F4F4');
final kSecondaryColor = getColorFromHex('#BAD001');
final kDangerColor = getColorFromHex('#F53D3D');
final kDarkColor = getColorFromHex('#222');
final kGreyColor = getColorFromHex('#dedede');

final kAppBarHeight = 40.0;
final kAppBarFontSize = 16.0;

final kDefaultScreenPad = EdgeInsets.symmetric(
  horizontal: getPropScreenWidth(15), 
  vertical: getPropScreenWidth(10)
);
