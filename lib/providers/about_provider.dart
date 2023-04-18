
import 'package:benecol_flutter/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AboutProvider with ChangeNotifier { // Provider to handle health
  ApiService _api = new ApiService();
  AboutProvider({ Key? key });

  Map<String, dynamic> _aboutSec0 = {};
  get aboutSec0 => _aboutSec0;
  Map<String, dynamic> _aboutSec1 = {};
  get aboutSec1 => _aboutSec1;
  Map<String, dynamic> _aboutSec2 = {};
  get aboutSec2 => _aboutSec2;
  List<Map<String, dynamic>> _aboutProducts = [];
  get aboutProducts => _aboutProducts;
  // bool isLoadedAbout = false;

  Future<void> getAbouts(BuildContext context, String langId) async {
    resetAbouts(){
      _aboutSec0 = {};
      _aboutSec1 = {};
      _aboutSec2 = {};
      _aboutProducts = [];
      notifyListeners();
    }
    String apiUrl = 'content/about?lang=$langId';
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
        _aboutSec0['title'] = _articles[0]['title'];
        _aboutSec0['paragraphs'] = _articles[0]['paragraphs'];

        _aboutSec1['title'] = _articles[1]['title'];
        _aboutSec1['youtube_id'] = _articles[1]['youtube_id'];
        _aboutSec1['image'] = _articles[1]['images'].length > 0 ? _articles[1]['images'][0]['path'] : "assets/images/ImageBanner/yutobe.jpg";

        _aboutSec2['title'] = _articles[2]['title'];
        _aboutSec2['paragraphs'] = _articles[2]['paragraphs'];

        var _products = _contents['products'];
        for(int i = 0; i < _products.length; i++){
          Map<String, dynamic> item = {
            'product_id': _products[i]['description'][0]['content_id'],
            'name': _products[i]['description'][0]['title'],
            'desc': _products[i]['description'][0]['description'],
            'image': _products[i]['images'].length > 0 ? _products[i]['images'][0]['path'] : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7',
          };
          _aboutProducts.add(item);
        }
      }else{
        _aboutSec0 = {};
        _aboutSec1 = {};
        _aboutSec2 = {};
        _aboutProducts = [];
      }
      notifyListeners();
      EasyLoading.dismiss();
    }catch (e){
      _aboutSec0 = {};
      _aboutSec1 = {};
      _aboutSec2 = {};
      _aboutProducts = [];
      notifyListeners();
      EasyLoading.dismiss();
    }
  }

  Map<String, dynamic> _productDetail = {};
  get productDetail => _productDetail;

  Future<void> getProductDetail(BuildContext context, String langId, int productId) async {
    resetProductDetail(){
      _productDetail = {};
      notifyListeners();
    }
    String apiUrl = 'content/productDetail/$productId?lang=$langId';
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