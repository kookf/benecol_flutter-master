import 'dart:convert';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_product_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductFormScreen extends StatelessWidget {
  ExchangeProductFormScreen({ Key? key }) : super(key: key);
  static final routeName = 'exchange_product_form';
  late AppLocalizations T;

  getArgumentJson(BuildContext context){
    final _arguments = ModalRoute.of(context)!.settings.arguments;
    return json.decode(json.encode(_arguments));
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    final _arguments = getArgumentJson(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '地址信息',
          T.exchangeProductFormTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ExchangeProductFormBody(
        arguments: _arguments
      )
    );
  }
}