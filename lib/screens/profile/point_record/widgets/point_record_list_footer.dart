
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordListFooter extends StatelessWidget {
  final String lastDay;
  late AppLocalizations T;

  PointRecordListFooter({
    Key? key,
    required this.lastDay
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
                // '記錄截至',
                T.pointRecordFooterTitle,
                style: TextStyle(
                  fontSize: 17,
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
                lastDay,
                style: TextStyle(
                  fontSize: 17,
                )
              ),
            )
          ),
        ),
      ],
    );
  }
}

