
import 'package:benecol_flutter/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AboutOatProvider with ChangeNotifier { // Provider to handle health
  ApiService _api = new ApiService();
  AboutOatProvider({ Key? key });

  Map<String, dynamic> _aboutOatSec0 = {};
  get aboutOatSec0 => _aboutOatSec0;
  Map<String, dynamic> _aboutOatSec1 = {};
  get aboutOatSec1 => _aboutOatSec1;
  Map<String, dynamic> _aboutOatSec2 = {};
  get aboutOatSec2 => _aboutOatSec2;
  Map<String, dynamic> _aboutOatSec3 = {};
  get aboutOatSec3 => _aboutOatSec3;
  Map<String, dynamic> _aboutOatSec4 = {};
  get aboutOatSec4 => _aboutOatSec4;
  Map<String, dynamic> _aboutOatSec5 = {};
  get aboutOatSec5 => _aboutOatSec5;
  Map<String, dynamic> _aboutOatSec6 = {};
  get aboutOatSec6 => _aboutOatSec6;
  Map<String, dynamic> _aboutOatSec7 = {};
  get aboutOatSec7 => _aboutOatSec7;
  List<Map<String, dynamic>> _aboutOatProducts = [];
  get aboutOatProducts => _aboutOatProducts;
  // bool isLoadedAbout = false;

  Future<void> getAboutOats(BuildContext context, String langId) async {
    resetAbouts(){
      _aboutOatSec0 = {};
      _aboutOatSec1 = {};
      _aboutOatSec2 = {};
      _aboutOatSec3 = {};
      _aboutOatSec4 = {};
      _aboutOatSec5 = {};
      _aboutOatSec6 = {};
      _aboutOatSec7 = {};
      _aboutOatProducts = [];
      notifyListeners();
    }
    String apiUrl = 'content/aboutOat?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetAbouts();
    try{
      // if(isLoadedAbout) return;
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        var _articles = _contents['articles'];

        _aboutOatSec0['title'] = _articles[0]['title'];
        _aboutOatSec0['youtube_id'] = _articles[0]['youtube_id'];
        _aboutOatSec0['image'] = _articles[0]['images'].length > 0 ? _articles[0]['images'][0]['path'] : "assets/images/ImageBanner/yutobe.jpg";

        _aboutOatSec1['title'] = _articles[1]['title'];
        _aboutOatSec1['paragraphs'] = _articles[1]['paragraphs'];

        _aboutOatSec2['title'] = _articles[2]['title'];
        _aboutOatSec2['image'] = _articles[2]['images'].length > 0 ? _articles[2]['images'][0]['path'] : "";

        _aboutOatSec3['title'] = _articles[3]['title'];
        _aboutOatSec3['paragraphs'] = _articles[3]['paragraphs'];

        _aboutOatSec4['title'] = _articles[4]['title'];
        _aboutOatSec4['image'] = _articles[4]['images'].length > 0 ? _articles[4]['images'][0]['path'] : "";

        _aboutOatSec5['title'] = _articles[5]['title'];
        _aboutOatSec5['paragraphs'] = _articles[5]['paragraphs'];

        _aboutOatSec6['title'] = _articles[6]['title'];
        _aboutOatSec6['image'] = _articles[6]['images'].length > 0 ? _articles[6]['images'][0]['path'] : "";

        _aboutOatSec7['title'] = _articles[7]['title'];
        _aboutOatSec7['paragraphs'] = _articles[7]['paragraphs'];

        var _products = _contents['products'];
        for(int i = 0; i < _products.length; i++){
          Map<String, dynamic> item = {
            'product_id': _products[i]['description'][0]['content_id'],
            'name': _products[i]['description'][0]['title'],
            'desc': _products[i]['description'][0]['description'],
            'image': _products[i]['images'].length > 0 ? _products[i]['images'][0]['path'] : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7',
          };
          _aboutOatProducts.add(item);
        }
      }else{
        _aboutOatSec0 = {};
        _aboutOatSec1 = {};
        _aboutOatSec2 = {};
        _aboutOatSec3 = {};
        _aboutOatSec4 = {};
        _aboutOatSec5 = {};
        _aboutOatSec6 = {};
        _aboutOatSec7 = {};
        _aboutOatProducts = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _aboutOatSec0 = {};
      _aboutOatSec1 = {};
      _aboutOatSec2 = {};
      _aboutOatProducts = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Map<String, dynamic> _productDetail = {};
  get productDetail => _productDetail;

  Future<void> getOatProductDetail(BuildContext context, String langId, int productId) async {
    resetProductDetail(){
      _productDetail = {};
      notifyListeners();
    }
    String apiUrl = 'content/oatProductDetail/$productId?lang=$langId';
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetProductDetail();
    try{
      EasyLoading.show();
      response = await _api.get(
        apiUrl
      );
      result['success'] = (response['errors'] == false);
      if(!!result['success']){
        var _contents = response['data']['contents'];
        var _images = [];
        for(int i = 0; i < _contents[0]['images'].length; i++){
          _images.add(_contents[0]['images'][i]['path']);
        }

        var _articles = [];
        for(int i = 0; i < _contents[0]['description'].length; i++){
          var _title = _contents[0]['description'][i]['title'];
          var _para = _contents[0]['description'][i]['description'];
          _articles.add({
            "title": _title,
            "paragraph": _para
          });
        }

        var facts = [];
        for(int i = 0 ; i < _contents[0]['facts'].length; i++){
          var col1 = _contents[0]['facts'][i]['description'][0]['title'];
          var col2 = _contents[0]['facts'][i]['description'][0]['per100ml'];
          var col3 = _contents[0]['facts'][i]['description'][0]['perBottle'];
          facts.add({
            "col1": col1,
            "col2": col2,
            "col3": col3
          });
        }

        _productDetail = {
          "images": _images,
          "articles": _articles,
          "facts": facts
        };
        notifyListeners();
      }else{
        resetProductDetail();
      }
      EasyLoading.dismiss();
    }catch(e){
      resetProductDetail();
      EasyLoading.dismiss();
    }
  }
}