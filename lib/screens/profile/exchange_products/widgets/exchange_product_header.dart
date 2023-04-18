import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductHeader extends StatelessWidget {
  final Map<String, String> icon;
  final String point;
  late AppLocalizations T;

  ExchangeProductHeader({
    Key? key,
    required this.icon,
    required this.point
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 7
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, right: 5),
            child: Image.asset(
              icon['title']!,
              width: 30,
            ),
          ),
          Expanded(
            child: Text(
              // '兌換禮品',
              T.exchangeProductsHeader,
              style: TextStyle(
                fontSize: 17,
                color: kPrimaryColor
              )
            ),
          ),
          Text(
            // '總積分: $point',
            '${T.exchangeProductsHeaderPointPrefix}$point',
            style: TextStyle(
              fontSize: 17,
              color: kPrimaryColor
            )
          )
        ],
      )
    );
  }
}