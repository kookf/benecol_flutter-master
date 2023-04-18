
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreBodyDivider extends StatelessWidget {
  StoreBodyDivider({
    Key? key,
  }) : super(key: key);

  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider()
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15
            ),
            child: Text(
              // "或",
              T.storeBodyDividerText,
              style: TextStyle(
                fontSize: 12
              )
            ),
          ),
          Expanded(
            child: Divider()
          ),
        ],
      ),
    );
  }
}