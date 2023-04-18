import 'package:flutter/material.dart';
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordListHeader extends StatelessWidget {
  late AppLocalizations T;

  PointRecordListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5
            ),
            child: Center(
              child: Text(
                // '積分細明',
                T.pointRecordListPointHeader,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                )
              ),
            )
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5
            ),
            child: Center(
              child: Text(
                // '到期日',
                T.pointRecordListDateHeader,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                )
              ),
            )
          ),
        ),
      ],
    );
  }
}
