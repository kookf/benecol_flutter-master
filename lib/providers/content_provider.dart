
import 'dart:developer';

import 'package:benecol_flutter/services/apiService.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ContentProvider with ChangeNotifier { // Provider to handle content
  ApiService _api = new ApiService();
  LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();

  Map<String, dynamic> _reminderContent = {};
  get reminderContent => _reminderContent;

  ContentProvider({ Key? key });

  Future<void> getReminderContent(BuildContext context, String langId) async {
    void resetReminderContent(){
      _reminderContent = {};
      notifyListeners();
    }

    String pageKey = 'reminder';
    String apiUrl = 'content/page?key=$pageKey&lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetReminderContent();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _resArticle = response['data']['contents']['articles'][0];
        _reminderContent['title'] = _resArticle['title'];
        _reminderContent['subTitle'] = _resArticle['sub_title'];
        _reminderContent['description'] = _resArticle['paragraphs'];
      }else{
        _reminderContent = {};
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _reminderContent = {};
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  List<Map<String, dynamic>> _latestContents = [];
  get latestContents => _latestContents;

  Future<void> getLatestContents(BuildContext context, String langId) async {
    void resetLatestContent(){
      _latestContents = [];
      notifyListeners();
    }

    String apiUrl = 'content/latest-offer?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetLatestContent();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];

        for(int i = 0; i < _contents.length; i++){
          var _content = _contents[i];
          var _description = !(_content['description'].isEmpty) ?_content['description'][0] : {};
          var _image = !(_content['images'].isEmpty) ? _content['images'][0] : {};
          var _latestContent = {
            'id': _description['content_id'],
            'title': _description['title'],
            'sub_title': _description['sub_title'],
            'image': _image['path'],
          };
          _latestContents.add(_latestContent);
        }
      }else{
        _latestContents = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _latestContents = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Map<String, dynamic> _newsDetail = {};
  get newsDetail => _newsDetail;

  Future<void> getNewsDetail(BuildContext context, String langId, String newId) async {
    void resetNewsDetail(){
      _newsDetail = {};
      notifyListeners();
    }

    String apiUrl = 'content/show/$newId?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetNewsDetail();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        var _content = _contents[0];
        var _images = [];
        var _articles = [];
        var _facts = [];
        for(int i = 0; i < _content['images'].length; i++){
          _images.add(_content['images'][i]['path']);
        }
        for(int j = 0; j < _content['description'].length; j++){
          _articles.add({
            "title": _content['description'][j]['sub_title'],
            "paragraph": _content['description'][j]['description'],
            "url": (_content['url'] != null) ? _content['url'] : ''
          });
        }
        for(int k = 0; k < _content['facts'].length; k++){
          _facts.add({
            "col1": _content['facts'][k]['description'][0]['title'],
            "col2": _content['facts'][k]['description'][0]['per100ml'],
            "col3": _content['facts'][k]['description'][0]['perBottle']
          });
        }
        _newsDetail = {
          "images": _images,
          "articles": _articles,
          "facts": _facts
        };
      }else{
        _newsDetail = {};
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _newsDetail = {};
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Map<String, dynamic> _instructionDetail = {};
  get instructionDetail => _instructionDetail;

  Future<void> getInstructionDetail(BuildContext context, String langId) async {
    resetInstructionDetail(){
      _instructionDetail = {};
      notifyListeners();
    }
    String apiUrl = 'content/page?key=instruction&lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetInstructionDetail();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        var _articles = _contents['articles'];
        var _slides = [];
        var _items = [];
        String _title;
        String _description;
        if(_articles != null){
          for(int i = 0; i < _articles.length; i++){
            if(i == 0){
              try{
                _title = _contents['title'];
                _instructionDetail['title'] = _title;
                _description = _articles[i]['paragraphs'];
                _instructionDetail['description'] = _description;

                if(_articles[i]['images'] != null){
                  for(int j = 0; j < _articles[i]['images'].length; j++){
                    String _aTitle = _articles[i]['title'];
                    String _subTitle = _articles[i]['sub_title'];
                    String _path = _articles[i]['images'][j]['path'];
                    _slides.add({
                      "title": _aTitle,
                      "subTitle": _subTitle,
                      "path": _path
                    });
                  }
                }
              }catch(e){
              }
            }else{
              var _item = {
                "id": _articles[i]['content_id'],
                "name": _articles[i]['title'],
                "desc": _articles[i]['paragraphs'],
                "image": _articles[i]['images']
              };
              _items.add(_item);
            }
          }
        }

        _instructionDetail['slides'] = _slides;
        _instructionDetail['items'] = _items;	
        
        notifyListeners();
      }else{
        _instructionDetail = {};
      }
      EasyLoading.dismiss();
    }catch(e){
      _instructionDetail = {};
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  List<Map<String, dynamic>> _promotionBooth = [];
  get promotionBooth => _promotionBooth;

  Future<void> getPromotionBooth(BuildContext context, String langId) async {
    void resetPromotionBooth(){
      _promotionBooth = [];
      notifyListeners();
    }

    String apiUrl = 'content/promotion-booth?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetPromotionBooth();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        for(int i = 0; i < _contents.length; i++){
          String _title = _contents[i]?['description']?[0]?['title'] ?? '';
          List<dynamic> _booths = [];
          for(int j = 0; j < (_contents[i]?['promotion_booth']?.length ?? 0); j++){
            var _promotionBooth = _contents[i]['promotion_booth'][j];
            var _period = _promotionBooth['description'][0]['period'];
            var _name = _promotionBooth['description'][0]['name'];
            var _store = _promotionBooth['description'][0]['store'];
            _booths.add({
              "period": _period,
              "name": _name,
              "store": _store
            });
          }
          _promotionBooth.add({
            "title": _title,
            "booths": _booths
          });
        }
      }else{
        _promotionBooth = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch(e){
      _promotionBooth = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  List<String> _receipts = [];
  get receipt => _receipts;

  Future<void> getReceipts(BuildContext context, String langId) async {
    void resetReceipts(){
      _receipts = [];
      notifyListeners();
    }

    String apiUrl = 'content/receipts?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetReceipts();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        for(int i = 0; i < _contents.length; i++){
          String receiptUrl = _contents[i]?["images"]?[0]?["path"] ?? '';
          _receipts.add(receiptUrl);
        }
      }else{
        _receipts = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch(e){
      _receipts = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }
}