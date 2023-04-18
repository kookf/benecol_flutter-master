
import 'package:benecol_flutter/services/apiService.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HealthProvider with ChangeNotifier { // Provider to handle health
  ApiService _api = new ApiService();
  LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
  HealthProvider({ Key? key });

  List<Map<String, dynamic>> _news = [];
  get news => _news;

  Future<void> getNews(BuildContext context, String langId) async {
    void resetNews(){
      _news = [];
      notifyListeners();
    }
    String apiUrl = 'content/news?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetNews();
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
          if(!(_content['description'].isEmpty)){
            var _description = _content['description'][0];
            var _title = _description['title'];
            var _images = [];
            bool _skip = true;
            for(int i = 0; i < _content['images'].length; i++){
              _images.add(_content['images'][i]['path']);
              _skip = false;
            }
            String _openLink = '';
            if(_images.length == 0){
              _openLink = _description['description'];
              _skip = false;
            }
            if(!_skip){
              news.add({
                "title": _title,
                "images": _images,
                "open": _openLink
              });
            }
          }
        }
      }else{
        _news = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _news = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  List<Map<String, dynamic>> _tips = [];
  get tips => _tips;

  Future<void> getTips(BuildContext context, String langId) async {
    void resetTips(){
      _tips = [];
      notifyListeners();
    }
    String apiUrl = 'content/tips?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetTips();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        var _content = _contents[0];
        var _sections = _content['sections'];
        for(int i = 0; i < _sections.length; i++){
          var _description = _sections[i]['description'][0];
          var _title = _description['title'];
          var _tipContent = _description['description'];
          _tips.add({
            "title": _title,
            "content": _tipContent
          });
        }
      }else{
        _tips = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _tips = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  List<Map<String, dynamic>> _chols = [];
  get chols => _chols;

  Future<void> getChols(BuildContext context, String langId) async {
    void resetChols(){
      _chols = [];
      notifyListeners();
    }
    String apiUrl = 'content/cholesterol?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetChols();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        var _content = _contents[0];
        var _sections = _content['sections'];
        for(int i = 0; i < _sections.length; i++){
          var _description = _sections[i]['description'][0];
          var _title = _description['title'];
          var _cholsContent = _description['description'];
          _chols.add({
            "title": _title,
            "content": _cholsContent
          });
        }
      }else{
        _chols = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _chols = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }
}