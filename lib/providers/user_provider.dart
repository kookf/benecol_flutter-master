
import 'dart:convert';
import 'package:benecol_flutter/models/profile.dart';
import 'package:benecol_flutter/services/apiService.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProvider with ChangeNotifier { // Provider to handle signup / login / logout
  ApiService _api = new ApiService();
  LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
  /* isLogin */
  bool _isLogin = false;
  get isLogin => _isLogin;
  /* userProfile */
  Profile _userProfile = Profile(
    firstName: "", 
    lastName: "", 
    phone: "", 
    birthday: "", 
    gender: "", 
    areaId: "", 
    income: "", 
    email: ""
  );
  get userProfile => _userProfile;
  /* userPoint */
  Map<String, dynamic>? _userPoint;
  get userPoint => _userPoint;
  /* userPointList */
  List<Map<String, dynamic>> _userPointList = [];
  get userPointList => _userPointList;
  /* userAddressList */
  List<Map<String, dynamic>> _userAddressList = [];
  get userAddressList => _userAddressList;
  /* userMessageList */
  List<Map<String, dynamic>> _userMessageList = [];
  get userMessageList => _userMessageList;
  /* userPointRecordList */
  List<Map<String, dynamic>> _userPointRecordList = [];
  get userPointRecordList => _userPointRecordList;

  UserProvider({ Key? key });
  void resetUserProfile(){
    _userProfile = Profile(
      firstName: "", 
      lastName: "", 
      phone: "", 
      birthday: "", 
      gender: "", 
      areaId: "", 
      income: "", 
      email: ""
    );
  }
  
  Future<Map<String, dynamic>> profile() async {
    // final response = await _api.get('content/faq?lang=$langId');
    String apiUrl = 'users/me?token=';
    Map<String, dynamic> result = {};
    final response;
    var responseData;

    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    apiUrl = apiUrl + idToken;

    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl,
      );
      EasyLoading.dismiss();
      if(response['errors']==false){
        Map<String, dynamic> data = response['data'];
        _userProfile = new Profile(
          firstName: data['first_name'], 
          lastName: data['last_name'], 
          phone: data['phone'], 
          birthday: data['birthday'] ?? '', 
          gender: data['gender'] ?? '', 
          areaId: data['area_id'], 
          income: data['income'] ?? '', 
          email: data['email']
        );

        notifyListeners();
      }
    }catch(e){
      EasyLoading.dismiss();
    }
    return result;
  }

  Future<Map<String, dynamic>> updateProfile(BuildContext context, Map<String, dynamic> formData) async {
    AppLocalizations T = AppLocalizations.of(context)!;
    String apiUrl = 'users/me?token=';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    var submitFormData = {
      "data": formData
    };

    // submitFormData['data']!['current_password'] = '';
    // submitFormData['data']!['new_password'] = '';
    // submitFormData['data']!['new_password_confirmation'] = '';

    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';

    apiUrl = apiUrl + idToken;

    try{
      EasyLoading.show();
      response = await _api.post(
        apiUrl,
        sendObj: json.encode(submitFormData)
      );
      EasyLoading.dismiss();
      result['success'] = (response['errors'] == false);
      if(result['success']){
        // showNoIconMessageDialog('更改資料成功。');
        showNoIconMessageDialog(T.profileUpdateSuccess);
      }
      return result;
    }catch(e){
      var errorJson = jsonDecode(e.toString()),
        errorBody = errorJson['body'],
        errorStatusCode = errorBody['status_code'],
        errors = errorBody['errors'];
      
      EasyLoading.dismiss();
      result['success'] = false;
      switch(errorStatusCode){
        case 400:
          if(errors == null) break;
          var errorMessage = errors['message'];
          var errorMessageTranslate = '';
          for(int i = 0; i < errorMessage.length; i ++){
            if(errorMessage[i]["data.current_password"] != null){
              // print('Found data.current_password error!');
              result['type'] = 'INVALID_PASSWORD_ERROR';
              // errorMessageTranslate = '密碼不正確。';
              errorMessageTranslate = T.profileUpdateWrongPassword;
            }
          }
          showNoIconMessageDialog(errorMessageTranslate);
          break;
        case 402:
          var errorMessage = errors['message'];
          // var errorMessageTranslate = 'Token Expired Error.';
          var errorMessageTranslate = T.profileUpdateTokenExpire;
          result['type'] = 'TOKEN_EXPIRE_ERROR';
          showNoIconMessageDialog(errorMessageTranslate);
          break;
        case 422:
          if(errors == null) break;
          var errorMessage = errors['message'];
          // var errorMessageTranslate = 'Empty Data Error.';
          var errorMessageTranslate = T.profileUpdateEmptyData;
          result['type'] = 'EMPTY_DATA_ERROR';
          showNoIconMessageDialog(errorMessageTranslate);
          break;
        default:
          result['type'] = 'UNCAUGHT_ERROR';
          break;
      }
      return result;
    }
  }

  Future<Map<String, dynamic>> applyPoints(BuildContext context, Map<String, dynamic> $params, List invoicePathList) async {
    // AppLocalizations T = AppLocalizations.of(context)!;
    String apiUrl = 'users/points-apply?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    apiUrl = apiUrl + idToken;
    try{
      EasyLoading.show();
      response = await _api.postSingleImage(
        apiUrl,
        params: $params,
          imagePathList: invoicePathList
      );
      result['success'] = (response['errors'] == false);
      if(!result['success']){
        result['errorType'] = 'DEFAULT_ERROR';
      }
      print('==============${response}');
      EasyLoading.dismiss();
    }catch (e){
      print('==============${e.toString()}');
      EasyLoading.dismiss();
      result['success'] = false;
      var errorJson = jsonDecode(e.toString()),
        errorBody = errorJson['body'],
        errorStatusCode = errorBody['status_code'],
        errors = errorBody['errors'];

        result['errorType'] = 'DEFAULT_ERROR';
        if(errorStatusCode == 406 && errors['message'] != null){
          for(int i = 0; i < errors['message'].length; i++){
            if(errors['message'][i] == "error:Apply date out 180days!"){
              result['errorType'] = 'OVER_180DAY_ERROR';
              break;
            }
          }
        }
    }
    return result;
  }

  Future<void> getUserPoint(BuildContext context, String langId) async {
    void resetUserPointData(){
      _userPoint = {};
      _userPointList = [];
      notifyListeners();
    }

    // AppLocalizations T = AppLocalizations.of(context)!;
    String apiUrl = 'users/points-info?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    apiUrl = apiUrl + idToken;
    resetUserPointData();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){

        _userPoint!['points'] = response['data']['points'];
        _userPoint!['endTime'] = response['data']['end_time'];
        _userPoint!['lastDay'] = response['data']['last_day'];

        var _resPointList = response['data']['overpoints'];

        for(int i = 0; i < _resPointList.length; i++){
          Map<String, dynamic> _pointRecord = {
            'points': _resPointList[i]['points'],
            'usePoints': _resPointList[i]['use_points'],
            'endTime': _resPointList[i]['end_time']
          };
          _userPointList.add(_pointRecord);
        }
      }else{
        _userPoint = {};
        _userPointList = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _userPoint = {};
      _userPointList = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Future<void> getUserAddressList(BuildContext context) async {
    void resetUserAddressList(){
      _userAddressList = [];
      notifyListeners();
    }

    String apiUrl = 'users/address-list?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    apiUrl = apiUrl + idToken;
    resetUserAddressList();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var data = response['data']['data'];
        for(int i = 0; i < data.length; i++){
          Map<String, dynamic> _userAddress = {
            'id': data[i]['id'],
            'address': data[i]['address'],
            'name': data[i]['name'],
            'phone': data[i]['phone']
          };
          _userAddressList.add(_userAddress);
        }
      }else{
        _userAddressList = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _userAddressList = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Future<Map<String, dynamic>> updateUserAddress(BuildContext context, Map<String, dynamic> form) async {
    String apiUrl = 'users/add-address?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    Map<String, dynamic> result = {};
    final response;
    apiUrl = apiUrl + idToken;
    try{
      EasyLoading.show();
      response = await _api.post(
        apiUrl,
        sendObj: json.encode(form)
      );
      EasyLoading.dismiss();
      result['success'] = (response['errors'] == false);
      return result;
    }catch (e){
      EasyLoading.dismiss();
      result['success'] = false;
      return result;
    }
  }

  Future<Map<String, dynamic>> deleteUserAddress(BuildContext context, int id) async {
    String apiUrl = 'users/user-address?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    String addressId = '&id=$id';
    Map<String, dynamic> result = {};
    final response;
    apiUrl = apiUrl + idToken + addressId;
    try{
      EasyLoading.show();
      response = await _api.post(
        apiUrl
      );
      EasyLoading.dismiss();
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        for(int i = 0; i < _userAddressList.length; i++){
          if(_userAddressList[i]['id'] == id){
            _userAddressList.removeAt(i);
          }
        }
        notifyListeners();
      }
      return result;
    }catch (e){
      EasyLoading.dismiss();
      result['success'] = false;
      return result;
    }
  }

  Future<void> getUserMessageList(BuildContext context) async {
    void resetUserMessageList(){
      _userMessageList = [];
      notifyListeners();
    }

    String apiUrl = 'users/jpush?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    apiUrl = apiUrl + idToken;
    resetUserMessageList();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var data = response['data']['data'];
        for(int i = 0; i < data.length; i++){
          Map<String, dynamic> _userMessage = {
            'id': data[i]['id'],
            'content': data[i]['content'],
            'createAt': data[i]['created_at']
          };
          _userMessageList.add(_userMessage);
        }
      }else{
        _userMessageList = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _userMessageList = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Future<Map<String, dynamic>> deleteUserMessage(BuildContext context, int id) async {
    String apiUrl = 'users/jpush?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    String addressId = '&id=$id';
    Map<String, dynamic> result = {};
    final response;
    apiUrl = apiUrl + idToken + addressId;
    try{
      EasyLoading.show();
      response = await _api.post(
        apiUrl
      );
      EasyLoading.dismiss();
      result['success'] = (response['errors'] == false);
      return result;
    }catch (e){
      EasyLoading.dismiss();
      result['success'] = false;
      return result;
    }
  }

  Future<Map<String, dynamic>> getUserPointRecordList(BuildContext context, String langId, String page) async {
    void resetUserPointRecordListData(){
      _userPointRecordList = [];
      notifyListeners();
    }

    // // AppLocalizations T = AppLocalizations.of(context)!;
    String apiUrl = 'users/points?token=';
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    String pageParam = '&page=$page';
    String langParam = '&lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    apiUrl = apiUrl + idToken + pageParam + langParam;
    if(page == '1'){ // Only reset data when getting first page data
      resetUserPointRecordListData();
    }
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _resPointRecordList = response['data']['lists'];
        _userPoint?['points'] = response['data']['points'];
        result['dataLength'] = _resPointRecordList.length;
        for(int i = 0; i < _resPointRecordList.length; i++){
          Map<String, dynamic> _pointRecord = {
            'points': _resPointRecordList[i]['points'],
            'memo': _resPointRecordList[i]['memo'],
            'type': _resPointRecordList[i]['type'],
            'quanity': _resPointRecordList[i]['quanity'],
            'createAt': _resPointRecordList[i]['created_at'],
            'userApply': _resPointRecordList[i]['userapply'],
            'flag': _resPointRecordList[i]['flag']
          };
          _userPointRecordList.add(_pointRecord);
        }
      }else{
        _userPointRecordList = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
      return result;
    }catch (e){
      _userPointRecordList = [];
      notifyListeners();
      EasyLoading.dismiss();
      return result;
    }
  }
}