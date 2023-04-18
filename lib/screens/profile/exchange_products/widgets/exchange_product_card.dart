import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/exchange_product.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_detail/exchange_product_detail_screen.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/exchange_product_form_screen.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductCard extends StatelessWidget {
  final ExchangeProduct product;
  final int userPoint;
  final VoidCallback onExchangeSuccessCallback;
  late AppLocalizations T;

  ExchangeProductCard({
    Key? key,
    required this.product,
    required this.userPoint,
    required this.onExchangeSuccessCallback
  }) : super(key: key);

  bool canExchange(){
    int _requiredPoint = double.parse(product.requiredPoints).toInt();
    int _quanity = int.parse(product.quanity);
    if(userPoint >= _requiredPoint && _quanity > 0){
      return true;
    }else{
      return false;
    }
  }


  bool canExchangeText(){
    int _requiredPoint = double.parse(product.requiredPoints).toInt();
    int _quanity = int.parse(product.quanity);
    if(userPoint >= _requiredPoint && _quanity > 0){
      return true;
    }else{
      return false;
    }
  }
  void showExchangeError(){
    // String _message = '抱歉，您的積分不足夠兌換該禮品，請重新選擇。';
    String _message = T.exchangeProductsCardNotEnoughPointError;
    if(int.parse(product.quanity) == 0){
      // _message = '抱歉，該禮品貨存數量為0，請重新選擇其他禮品。';
      _message = T.exchangeProductsCardNotEnoughQuanityError;
    }
    showNoIconMessageDialog(_message);
  }

  void onExchangeBtnClick(BuildContext context){
    bool _canExchange;
    _canExchange = canExchange();
    if(!_canExchange){
      showExchangeError();
      return;
    }
    //nav to exchange form screen
    // print('Can Exchage, naving to exchange form screen ${product.toString()}');
    if(product.id == 0) return;
    var arguments = {
      "userPoint": userPoint,
      "id": product.id,
      "title": product.title,
      "selectedQuanity": 1,
      "type": product.shipmentType,
      "point": product.requiredPoints,
      "productQuanity": product.quanity
    };
    Navigator.pushNamed(
      context, 
      ExchangeProductFormScreen.routeName, 
      arguments: arguments
    ).then((isExchanged){ // Call when screen pop back
      if(isExchanged == true){
        onExchangeSuccessCallback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: (){
        // print('exchange_product_card clicked with id ${product.id}');
        Navigator.pushNamed(
          context, 
          ExchangeProductDetailScreen.routeName, 
          arguments: product.id
        );
      },
      child: Container(
        width: SizeConfig.screenWidth < 598
        ?(SizeConfig.screenWidth * 0.5 - 7.5) // Mobile card width
        :(SizeConfig.screenWidth * 0.333 - 5.5), // Tablet card width
        // height: 260,
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Column(
          children:[
            Image.network(product.image),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // height:150,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(239, 238, 239, 1)
                    ),
                    child: Stack(
                      children:[ 
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 50
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                // height: 45,
                                child: Text(
                                  '${product.title}',
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    height: 1.1,
                                  )
                                ),
                              ),
                              SizedBox(height: 7),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  '\$${product.price}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right:0,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${T.exchangeProductsCardRequiredPointPrefix}${double.parse(product.requiredPoints).round()}',
                                  style: TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                SizedBox(height: 7),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 15,
                                    child: TextButton(

                                      onPressed: (){
                                        onExchangeBtnClick(context);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: canExchange() ? kSecondaryColor : Colors.grey,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                      ),
                                      child: Text(
                                        // '立即兌換',
                                          canExchangeText()? T.exchangeProductsCardExchangeNow:T.exchangeProductsCardExchangeSellOut,
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        )
                                      )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        )
                      ],
                    )
                  ),
                ),
              ],
            )
          ]
        )
      ),
    );
  }
}

