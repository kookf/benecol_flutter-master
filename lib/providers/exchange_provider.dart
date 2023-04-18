import 'dart:convert';
import 'package:benecol_flutter/models/exchange_product.dart';
import 'package:benecol_flutter/services/apiService.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExchangeProvider with ChangeNotifier { // Provider to handle signup / login / logout
  ExchangeProvider({ Key? key});

  ApiService _api = new ApiService();
  LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();

  List<Map<String, String>> _exchangeProductCategoryList = [];
  List<Map<String, String>> get exchangeProductCategoryList => _exchangeProductCategoryList;

  List<ExchangeProduct> _exchangeProducts = [];
  List<ExchangeProduct> get exchangeProducts => _exchangeProducts;
  
  ExchangeProduct? _exchangeProductDetail;
  ExchangeProduct? get exchangeProductDetail => _exchangeProductDetail;

  List<Map<String, dynamic>> _pickupAddressList = [];
  List<Map<String, dynamic>> get pickupAddressList => _pickupAddressList;

  Future<void> getExchangeProductCategoryList(String langId) async {
    void resetCategoryList(){
      _exchangeProductCategoryList = [];
      notifyListeners();
    }

    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetCategoryList();
    try{
      EasyLoading.show();
      response = await _api.get(
        'products/category-lists?lang=$langId'
      );
      EasyLoading.dismiss();
      result['success'] = response['errors'] == false;
      if(!!result['success']){
        var data = response['data'];
        var model = data['model'];
        for(int i = 0; i < model.length; i++ ){
          Map<String, String> _category = {
            "value": model[i]['id'].toString(),
            "text": model[i]["description"][0]["name"].toString()
          };
          _exchangeProductCategoryList.add(_category);
        }
      }
      notifyListeners();
    }catch (e){
      EasyLoading.dismiss();
    }
  }

  Future<Map<String, dynamic>> getExchangeProducts(String langId, int category) async {
    void resetExchangeProducts(){
      _exchangeProducts = [];
      notifyListeners();
    }

    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetExchangeProducts();
    try{
      EasyLoading.show();
      response = await _api.get(
        'products/index?lang=$langId&category=$category'
      );
      EasyLoading.dismiss();
      result['success'] = response['errors'] == false;
      if(result['success']){
        var data = response['data'];
        List<dynamic> model = data['model'];
        List<ExchangeProduct> products = [];
        model.forEach((e) {
          int id = e['id'];
          List descriptions = e['description'];
          Map<String, dynamic> description = descriptions[0];
          String descriptionContent = description['description'];
          String subTitle = description['sub_title'];
          String title = description['name'];
          List images = e['images'];
          Map<String, dynamic> image = images[0];
          Map<String, dynamic> imageUpload = image['upload'];
          String imagePath = imageUpload['path'];
          String price = e['old_price'].toString();
          String points = e['price'].toString();
          String quanity = e['quanity'].toString();
          int shipmentType = e['shipment_type'];
          ExchangeProduct _product = ExchangeProduct(
            id: id,
            title: title,
            price: price,
            requiredPoints: points,
            image: imagePath,
            description: descriptionContent,
            subTitle: subTitle,
            quanity: quanity,
            shipmentType: shipmentType
          );
          products.add(_product);
        });
        _exchangeProducts = products;
        notifyListeners();
      }
    }catch (e){
      EasyLoading.dismiss();
    }
    return {};
  }

  Future<void> getExchangeProductDetail(String langId, int productId) async {
    void resetExchangeProductDetail(){
      _exchangeProductDetail = null;
      notifyListeners();
    }

    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetExchangeProductDetail();
    try{
      EasyLoading.show();
      response = await _api.get(
        'products/product-detail?lang=$langId&id=$productId'
      );
      EasyLoading.dismiss();
      result['success'] = response['errors'] == false;
      if(result['success']){
        //get exchange product list success
        var data = response['data'];
        var model = data['model'];

        int id = model['id'];
        List descriptions = model['description'];
        Map<String, dynamic> description = descriptions[0];
        String descriptionContent = description['description'];
        String subTitle = description['sub_title'];
        String title = description['name'];
        List images = model['images'];
        Map<String, dynamic> image = images[0];
        Map<String, dynamic> imageUpload = image['upload'];
        String imagePath = imageUpload['path'];
        String price = model['old_price'].toString();
        String points = model['price'].toString();
        String quanity = model['quanity'].toString();
        int shipmentType = model['shipment_type'];
        ExchangeProduct _product = ExchangeProduct(
          id: id,
          title: title,
          price: price,
          requiredPoints: points,
          image: imagePath,
          description: descriptionContent,
          subTitle: subTitle,
          quanity: quanity,
          shipmentType: shipmentType
        );

        _exchangeProductDetail = _product;
        notifyListeners();
      }
    }catch (e){
      EasyLoading.dismiss();
    }
  }

  Future<void> getPickupAddressList(BuildContext context, String langId, int shipmentType) async {
    void resetPickupAddressList(){
      _pickupAddressList = [];
      notifyListeners();
    }

    Map<String, dynamic> result = {};
    final response;
    var responseData;
    resetPickupAddressList();
    try{
      EasyLoading.show();
      response = await _api.get(
        'products/pickup-address?lang=$langId&shipment_type=$shipmentType'
      );
      EasyLoading.dismiss();
      result['success'] = response['errors'] == false;
      if(!!result['success']){
        var data = response['data'];
        var model = data['model'];
        for(int i = 0; i < model.length; i++ ){
          Map<String, dynamic> _pickupAddress = model[i];
          _pickupAddressList.add(_pickupAddress);
        }
      }
      notifyListeners();
    }catch (e){
      EasyLoading.dismiss();
    }
  }

  Future<Map<String, dynamic>> addOrder(BuildContext context, Map<String, dynamic> data) async {
    Map<String, dynamic> result = {};
    final response;
    var responseData;
    try{
      EasyLoading.show();
      String idToken = await _localStorageSingleton.getValue('id_token') ?? '';
      response = await _api.post(
        'users/addorder?token=$idToken',
        sendObj: json.encode(data)
      );
      EasyLoading.dismiss();
      result['success'] = response['errors'] == false;
      return result;
    }catch (e){
      EasyLoading.dismiss();
      result['success'] = false;
      return result;
    }
  }
}