import 'package:benecol_flutter/services/apiService.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider with ChangeNotifier { // Provider to handle signup / login / logout
  AuthProvider({ Key? key});

  ApiService _api = new ApiService();
  LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();

  Future<bool> isAuthenticated() async {
    String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
    if(idToken == '') return false;
    bool hasExpired;
    try{
      hasExpired = JwtDecoder.isExpired(idToken);
    }catch(e){
      hasExpired = true;
    }
    return !hasExpired;
  }

  bool _isRegisteredFirebaseTestingTopic = false;
  bool get isRegisteredFirebaseTestingTopic => _isRegisteredFirebaseTestingTopic;
  void setIsRegisteredFirebasetestingTopic($boo){
    _isRegisteredFirebaseTestingTopic = $boo;
  }

  Future<void> logout() async{
    await _localStorageSingleton.setValue('id_token', '');
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  Future<Map<String, dynamic>> getCaptcha(String langId, String phone, String token) async {
    Map<String, String> smsData = {
      "phone": phone,
      "uuid": "benecol-app",
      "token": token,
      "lang": langId
    };
    Map<String, dynamic> result = {};

    final response;
    var responseData;
    try {
      response = await _api.post(
        'auth/sms',
        sendObj: json.encode(smsData)
      );
      responseData = response['data']['data'];
      result['success'] = true;
      result['captcha'] = responseData['captcha'];
      result['token'] = responseData['token'];
      return result;
    }catch (e){
      result['success'] = false;
      return result;
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> formData) async {
    final apiUrl = 'auth/register';
    Map<String, dynamic> result ={};
    final response;
    var responseData;
    try{
      response = await _api.post(
        apiUrl,
        sendObj: json.encode(formData)
      );
      result['success'] = (response['errors'] == false);
      return result;
    }catch(e){
      result['success'] = false;
      Map<String, dynamic>errorJson = json.decode(e.toString());
      Map<String, dynamic>errors = errorJson['body']['errors'];

      if((errors['email'] != null && errors['email'][0] == "The email has already been taken.") || (errors['message'] != null && errors['message'][0] == "The email has already been taken.")){
        result['type'] = 'EMAIL_TAKEN';
      }else if((errors['phone'] != null && errors['phone'][0] == "The phone number has already been taken.") || (errors['message'] != null && errors['message'][0] == "The phone number has already been taken.")){
        result['type'] = 'PHONE_TAKEN';
      }else if((errors['phone'] != null && errors['phone'][0] == "The phone must be a number.")){
        result['type'] = 'PHONE_FORMAT';
      }else{
        result['type'] = 'UNKOWN';
      }
      return result;
    }
  }

  Future<Map<String, dynamic>> forgetPassword(Map<String, dynamic> formData) async {
    final apiUrl = 'auth/password/email';
    Map<String, dynamic> result ={};
    final response;
    var responseData;
    try{
      response = await _api.post(
        apiUrl,
        sendObj: json.encode(formData)
      );
      result['success'] = (response['errors'] == false);
      return result;
    }catch(e){
      result['success'] = false;
      return result;
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> formData) async {
    
    final apiUrl = 'auth/login';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    late String _errorType;

    Map<String, dynamic> responseDataProcess(resObj, bool isCaught){
      late bool _isSuccess;
      late String _token;
      late Map<String, dynamic> _userObj;
      late String _email;
      late int? _statusCode;

      if(isCaught){
        _isSuccess = false;
      }else{
        _isSuccess = resObj["errors"] == false;
      }

      if(_isSuccess){
        _token = resObj['data']['token'];
        _userObj = resObj['data']['user'];
        _email = _userObj['email'];
        return {
          'success': _isSuccess,
          'token': _token,
          'user': _userObj,
          'email': _email
        };
      }else{
        try{
          _statusCode = resObj['body']['status_code'];
        }catch(e){
          _statusCode = null;
        }
        return{
          'success': _isSuccess,
          'status_code': _statusCode
        };
      }
    }

    try{
      EasyLoading.show();
      response = await _api.post(
        apiUrl,
        sendObj: json.encode(formData)
      );
      EasyLoading.dismiss();
      result = responseDataProcess(response, false);
    }catch(e){
      Map<String, dynamic>errorResponse = json.decode(e.toString());
      result = responseDataProcess(errorResponse, true);
    }
    //response actions
    if(result['success']){
      await _localStorageSingleton.setValue('id_token', result['token']);
      await _localStorageSingleton.setValue('email', result['email']);
      _isLogin = true;
      return {
        'isSuccess': true
      };
    }else{
      int? statusCode = result['status_code'];
      return {
        'isSuccess': false,
        'statusCode': statusCode
      };
    }
  }

  String _registrationId = '';
  String get registrationId => _registrationId;
  Future<void> setRegistrationId(rid) async {
    print('[AuthProvider] setRegistrationId called $rid');
    _registrationId = rid;
  }
}