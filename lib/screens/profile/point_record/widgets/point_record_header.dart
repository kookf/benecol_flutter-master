
import 'package:flutter/material.dart';
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordHeader extends StatelessWidget {
  int userPoint;
  late AppLocalizations T;
  final Map<String, String> icon;
  
  PointRecordHeader({
    Key? key,
    required this.icon,
    required this.userPoint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 12
              ),
              child: Image.asset(
                icon['title']!,
                width: 35,
              ),
            ),
            Text(
              // '積分記錄',
              T.pointRecordHeaderTitle,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 17
              ),
            )
          ],
        ),
        Text(
          // '總積分: $userPoint',
          '${T.pointRecordHeaderPointPrefix}$userPoint',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 17
          ),
        )
      ],
    );
  }
}