import 'package:benecol_flutter/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StoreProvider with ChangeNotifier { // Provider to handle store, location
  StoreProvider({ Key? key});
  List<Map<String, String>>? _districtData;
  List<Map<String, String>>? get districtData => _districtData;
  List<Map<String, String>>? _areaData;
  List<Map<String, String>>? get areaData => _areaData;
  List<Map<String, String>>? _storeData;
  List<Map<String, String>>? get storeData => _storeData;

  List<Map<String, dynamic>>? _locationData;
  List<Map<String, dynamic>>? get locationData => _locationData;

  bool _isLoadedDistrictData = false;
  bool get isLoadedDistrictData => _isLoadedDistrictData;
  bool _isLoadedAreaData = false;
  bool get isLoadedAreaData => _isLoadedAreaData;
  bool _isLoadedStoreData = false;
  bool get isLoadedStoreData => _isLoadedStoreData;

  bool _isLoadedLocationData = false;
  bool get isLoadedLocationData => _isLoadedLocationData;

  ApiService _api = new ApiService();

  Future<void> loadStores(langId) async {
    final apiUrl = 'content/store?lang=$langId';
    final response;
    try{
      EasyLoading.show();
      response = await _api.get(apiUrl);
      Map<String, dynamic> data = response['data'];
      List<dynamic> storeListStr = data['contents'];
      _storeData = List.generate(
        storeListStr.length, 
        (index) => {
          'value': storeListStr[index],
          'text': storeListStr[index]
        }
      );
      _isLoadedStoreData = true;
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      EasyLoading.dismiss();
    }
  }

  Future<void> loadArea(langId) async{
    final apiUrl = 'content/area?lang=$langId';
    final response;
    try{
      EasyLoading.show();
      response = await _api.get(apiUrl);
      Map<String, dynamic> data = response['data'];
      List<dynamic> areaListStr = data['contents'];
      _areaData = List.generate(
        areaListStr.length, 
        (index) => {
          'value': areaListStr[index],
          'text': areaListStr[index]
        }
      );
      _isLoadedAreaData = true;
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      EasyLoading.dismiss();
    }
  }

  Future<void> loadDistrict(langId) async{
    final apiUrl = 'content/district?lang=$langId';
    final response;
    try{
      EasyLoading.show();
      response = await _api.get(apiUrl);
      Map<String, dynamic> data = response['data'];
      List<dynamic> districtListStr = data['contents'];
      _districtData = List.generate(
        districtListStr.length, 
        (index) => {
          'id': districtListStr[index]['area'][0],
          'value': districtListStr[index]['district'],
          'text': districtListStr[index]['district']
        }
      );
      _isLoadedDistrictData = true;
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      EasyLoading.dismiss();
    }
  }

  Future<void> loadLocations(langId) async{
    final apiUrl = 'content/locations?lang=$langId';
    final response;
    try{
      EasyLoading.show();
      response = await _api.get(apiUrl);
      Map<String, dynamic> data = response['data'];
      List<dynamic> locationListStr = data['contents'];
      _locationData = List.generate(
        locationListStr.length,
        (index) => {
          "shopName": locationListStr[index]['shop_name'],
          "shopAddress": locationListStr[index]['shop_address'],
          "lat": locationListStr[index]['lat'],
          "lng": locationListStr[index]['lng'],
          "areaId": locationListStr[index]['area'],
          "districtId": locationListStr[index]['district'],
          "storeId": locationListStr[index]['store'],
        }
      );
      _isLoadedLocationData = true;
      EasyLoading.dismiss();
      notifyListeners();
    }catch (e){
      EasyLoading.dismiss();
    }
  }
}