import 'dart:developer';

import 'package:benecol_flutter/models/banner.dart';
import 'package:benecol_flutter/services/apiService.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({ Key? key});

  ApiService _api = new ApiService();
  late List<SingleBanner> homeBanners = [];

  void resetHomeBanners(){
    homeBanners = [];
  }

  Future<bool> fetchHomeBanner(int langId) async {
    resetHomeBanners();
    try {
      final response = await _api.get('content/home?lang=$langId');
      List<dynamic> banners = response['data']['contents'];
      int totalBanner = banners.length;
      homeBanners = new List<SingleBanner>.generate(totalBanner , (index){
        String bannerImage = banners[index]['images'][0]['path'];
        String bannerTitle = banners[index]['description'][0]['title'];
        String bannerSubTitle = banners[index]['description'][0]['sub_title'];
        Map<String, dynamic> bannerData = {
          "imagePath": bannerImage,
          "title": bannerTitle,
          "subTitle": bannerSubTitle,
        };
        return new SingleBanner.fromJSON(bannerData);
      });
      notifyListeners();
      return true;
    }catch (e){
      return false;
    }
  }

  late bool _isShownHomeAds = false;
  get isShownHomeAds => _isShownHomeAds;
  late String _homeAdsImage = '';

  void resetHomeAdsImage(){
    _homeAdsImage = '';
  }

  Future<String> fetchHomeAds(int langId) async {
    resetHomeAdsImage();
    try {
      //content/page?key=home-ad&lang=
      String pageKey = 'home-ad';
      String apiUrl = 'content/page?key=$pageKey&lang=$langId';
      final response = await _api.get(apiUrl);
      Map<String, dynamic> contents = response['data']['contents'];
      String imgPath = contents['articles'][0]['images'][0]['path']??'';
      _homeAdsImage = imgPath;
      _isShownHomeAds = true;
      // log(imgPath);
      notifyListeners();
      return _homeAdsImage;
    }catch (e){
      // log(e.toString());
      return '';
    }
  }
}