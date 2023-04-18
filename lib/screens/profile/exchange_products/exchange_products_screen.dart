import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/widgets/exchange_products_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductsScreen extends StatelessWidget {
  ExchangeProductsScreen({ Key? key }) : super(key: key);
  static final routeName = 'exchange_products';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '兌換禮品',
          T.exchangeProductsTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ExchangeProductsBody()
    );
  }
}