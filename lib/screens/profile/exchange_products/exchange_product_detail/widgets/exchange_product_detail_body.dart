import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/exchange_product.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/exchange_product_form_screen.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/exchange_provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductDetailBody extends StatefulWidget {
  final productId;

  const ExchangeProductDetailBody({ 
    Key? key,
    required this.productId
  }) : super(key: key);

  @override
  _ExchangeProductDetailBodyState createState() => _ExchangeProductDetailBodyState();
}

class _ExchangeProductDetailBodyState extends State<ExchangeProductDetailBody> {
  ExchangeProduct? _exchangeProduct;
  Map<String, dynamic>? _userPoint;
  bool _canExchange = false;
  final int _selectedQuanity = 1;
    late AppLocalizations T;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getExchangeProductDetail(context);
      getUserPoint(context);
    });
  }

  Future<void> getExchangeProductDetail(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<ExchangeProvider>().getExchangeProductDetail(_currentId.toString(), widget.productId);
  }

  Future<void> getUserPoint(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<UserProvider>().getUserPoint(context, _currentId.toString());
  }

  void showExchangeError(){
    // String _message = '抱歉，您的積分不足夠兌換該禮品，請重新選擇。';
    String _message = T.exchangeProductDetailNotEnoughPointError;
    if(int.parse(_exchangeProduct!.quanity) == 0){
      // _message = '抱歉，該禮品貨存數量為0，請重新選擇其他禮品。';
      _message = T.exchangeProductDetailNotEnoughQuanityError;
    }
    showNoIconMessageDialog(_message);
  }

  void checkCanExchange(){
    if(_userPoint==null || _userPoint!['points'] == null || _exchangeProduct==null) {
      _canExchange = false;
      return;
    }
    int _requiredPoint = double.parse(_exchangeProduct!.requiredPoints).toInt();
    int _productQuanity = int.parse(_exchangeProduct!.quanity);
    int _selectedQuanity = this._selectedQuanity;
    if(_userPoint!['points'] >= (_requiredPoint * _selectedQuanity) && _productQuanity > 0 && _productQuanity >= _selectedQuanity){
      _canExchange = true;
    }else{
      _canExchange = false;
    }
  }

  void onExchangeBtnClick(){
    if(_userPoint==null || _userPoint!['points'] == null || _exchangeProduct==null) return;
    if(_canExchange){
      // print('Can Exchange! ${_exchangeProduct!.title}');
      if(_exchangeProduct!.id == 0) return;
      var arguments = {
        "userPoint": _userPoint!['points'],
        "id": _exchangeProduct!.id,
        "title": _exchangeProduct!.title,
        "selectedQuanity": _selectedQuanity,
        "type": _exchangeProduct!.shipmentType,
        "point": _exchangeProduct!.requiredPoints,
        "productQuanity": _exchangeProduct!.quanity
      };
      Navigator.pushNamed(
        context, 
        ExchangeProductFormScreen.routeName, 
        arguments: arguments
      ).then((isExchanged){ // Call when screen pop back
        if(isExchanged == true){
          getExchangeProductDetail(context); // only called when exchange successed (isExchanged == true)
        }
      });
    }else{
      showExchangeError();
    }
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _exchangeProduct = context.watch<ExchangeProvider>().exchangeProductDetail;
    _userPoint = context.watch<UserProvider>().userPoint;
    checkCanExchange();
    
    return SingleChildScrollView(
      child: 
      (_exchangeProduct != null) 
      ? Column(
        children: [
          Image.network(_exchangeProduct!.image),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15
            ),
            child: Column(
              children: [
                buildProductTitle(),
                buildProductRequiredPoints(),
                buildProductPrice(),
                buildProductDescription(),
                buildProductSubTitle()
              ],
            ),
          ),
          GestureDetector(
            onTap: onExchangeBtnClick,
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _canExchange ? kSecondaryColor : Colors.grey
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // '立即兌換',
                    T.exchangeProductDetailExchangeNow,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                ],
              )
            ),
          )
        ],
      )
      : SizedBox()
    );
  }

  Column buildProductSubTitle() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 30,
          ),
          child: Text(
            // '禮品換領詳情:',
            T.exchangeProductDetailExchangeInfo,
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w300,
            )
          ),
        ),
        Container(
          width: double.infinity,
          child: Html(
            data: _exchangeProduct!.subTitle,
            style: {
              "body": Style(
                margin: EdgeInsets.zero,
                fontSize: FontSize(16)
              ),
              "ol": Style(
                listStylePosition: ListStylePosition.INSIDE,
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10
                ),
              ),
              "li": Style(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0
                ),
              )
            }
          )
        )
      ],
    );
  }

  Column buildProductDescription() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 30,
            bottom: 15
          ),
          child: Text(
            // '產品介紹:',
            T.exchangeProductDetailProductIntro,
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w300,
            )
          ),
        ),
        Container(
          width: double.infinity,
          child: Html(
            data: _exchangeProduct!.description,
            style: {
              "body": Style(
                margin: EdgeInsets.zero,
                fontSize: FontSize(16)
              ),
              "ol": Style(
                listStylePosition: ListStylePosition.INSIDE,
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10
                ),
              ),
              "li": Style(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0
                ),
              )
            }
          )
        )
      ],
    );
  }

  Container buildProductPrice() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 15
      ),
      child: Text(
        '${T.exchangeProductDetailProductPricePrefix}\$${_exchangeProduct!.price}'
      ),
    );
  }

  Container buildProductRequiredPoints() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 15
      ),
      child: Text(
        '${T.exchangeProductDetailProductPointPrefix}${_exchangeProduct!.requiredPoints}'
      ),
    );
  }

  Container buildProductTitle() {
    return Container(
      width: double.infinity,
      child: Text(
        _exchangeProduct!.title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: kSecondaryColor
        )
      ),
    );
  }
}