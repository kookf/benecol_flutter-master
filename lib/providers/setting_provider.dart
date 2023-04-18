import 'package:benecol_flutter/models/faq.dart';
import 'package:benecol_flutter/services/apiService.dart';
import 'package:benecol_flutter/services/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';

class SettingProvider with ChangeNotifier{
  SettingProvider({ Key? key });
  ApiService _api = new ApiService();

  /* app minimum version */
  int? _appMinVersion;
  get appMinVersion => _appMinVersion;

  Future<void> getAppMinimumVersion() async{
    try{
      final response = await _api.get('content/version');
      final version = response["version"];
      _appMinVersion = int.parse(version);
    }catch (e){
      // print('[SettingProvider] e $e');
    }
  }

  /* userPointRecordList */
  List<Map<String, dynamic>> _clauseContents = [];
  get clauseContents => _clauseContents;

  late bool notificationStatus = false;
  void getNotificationStatus() async{
    PermissionStatus status = await NotificationService.getNotificationStatus();
    if(status == PermissionStatus.granted){
      notificationStatus = true;
    }else{
      notificationStatus = false;
    }
    notifyListeners();
  }

  /* FAQ Section */
  late List<FAQ> faqList = [];
  void resetFaqList(){
    faqList = [];
  }
  Future<void> fetchFAQ(int langId) async{
    resetFaqList();
    try {
      final response = await _api.get('content/faq?lang=$langId');
      List<dynamic> faqs = response['data']['contents']['articles'];
      int totalFaqs = faqs.length;
      faqList = new List<FAQ>.generate(totalFaqs , (index){
        String title = faqs[index]['title'];
        String content = faqs[index]['paragraphs'];
        Map<String, dynamic> faqData = {
          "title": title,
          "content": content,
        };
        return new FAQ.fromJSON(faqData);
      });
      notifyListeners();
    }catch (e){
      print(e);
    }
  }

  /* Privacy Police Section */
  late List<Map<dynamic, dynamic>> privacyList = [];
  void resetPrivacyList(){
    privacyList = [];
  }
  Future<void> fetchPrivacy(int langId) async{
    resetPrivacyList();
    try {
      final response = await _api.get('content/privacy-policy?lang=$langId');
      List<dynamic> privacys = response['data']['contents']['articles'];
      int totalPrivacys = privacys.length;
      privacyList = new List<Map<dynamic, dynamic>>.generate(totalPrivacys , (index){
        String title = privacys[index]['title'];
        String content = privacys[index]['paragraphs'];
        Map<String, dynamic> privacyData = {
          "title": title,
          "content": content,
        };
        return privacyData;
      });
      notifyListeners();
    }catch (e){
      print(e);
    }
  }

  /* Legal Notice Section */
  late List<Map<dynamic, dynamic>> legalNoticeList = [];
  void resetLegalNoticeList(){
    legalNoticeList = [];
  }
  Future<void> fetchLegalNotice(int langId) async{
    resetLegalNoticeList();
    try {
      final response = await _api.get('content/legal-notice?lang=$langId');
      List<dynamic> legalNotices = response['data']['contents']['articles'];
      int totalLegalNotice = legalNotices.length;
      legalNoticeList = new List<Map<dynamic, dynamic>>.generate(
        totalLegalNotice, 
        (index){
          String title = legalNotices[index]['title'];
          String content = legalNotices[index]['paragraphs'];
          Map<String, dynamic> legalNoticeData = {
            "title": title,
            "content": content,
        };
        return legalNoticeData;
      });
      notifyListeners();
    }catch (e){
    }
  }

  /* Email Section */
  Future<bool> sendEmail(sendObj) async{
    try{
      final response = await _api.post(
        'content/email',
        sendObj: json.encode(sendObj)
      );
      return true;
    }catch (e){
      return false;
    }
  }

  Future<void> getClauseContents(BuildContext context, String langId) async {
    String apiUrl = 'content/page?key=clause&lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _resContents = response['data']['contents']['articles'];
        for(int i = 0; i < _resContents.length; i++){
          Map<String, dynamic> _content = {
            'title': _resContents[i]['title'],
            'paragraphs': _resContents[i]['paragraphs']
          };
          _clauseContents.add(_content);
        }
      }else{
        _clauseContents = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _clauseContents = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }
}