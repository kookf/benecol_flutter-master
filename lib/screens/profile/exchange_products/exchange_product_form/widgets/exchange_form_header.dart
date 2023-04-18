import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeFormHeader extends StatelessWidget {
  ExchangeFormHeader({
    Key? key,
    required String? shipmentTypeStr,
  }) : _shipmentTypeStr = shipmentTypeStr, super(key: key);

  final String? _shipmentTypeStr;
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: kSecondaryColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _shipmentTypeStr == 'address' 
            // ? '送貨服務' 
            ? T.exchangeProductFormShipmentHeader 
            // : '換領中心領取',
            : T.exchangeProductFormPickupHeader,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            )
          ),
        ],
      ),
    );
  }
}