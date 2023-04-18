import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_detail/widgets/exchange_product_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductDetailScreen extends StatelessWidget {
  ExchangeProductDetailScreen({ Key? key }) : super(key: key);
  static final routeName = 'exchange_product_detail';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    final _productId = ModalRoute.of(context)!.settings.arguments;
    T = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '禮品資料',
          T.exchangeProductDetailTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ExchangeProductDetailBody(productId: _productId)
    );
  }
}