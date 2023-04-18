
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorRecordCard extends StatelessWidget {
  Map<String, dynamic> record;
  int index;
  var deleteCallback;

  CalculatorRecordCard({
    Key? key,
    required this.index,
    required this.record,
    required this.deleteCallback
  }) : super(key: key);
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Dismissible(
      key: Key(record['date']),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showAlertDialogWithConfirmAndCancel(
          context,
          // content: '確定刪除紀錄？',
          content: T.calculatorConfirmDeleteRecordTxt,
          // confirmActionText: '確定',
          confirmActionText: T.dialogConfirm,
          // cancelActionText: '取消',
          cancelActionText: T.dialogCancel,
        );
      },
      onDismissed: (DismissDirection direction){
        deleteCallback(index);
      },
      background: Container(
        margin: EdgeInsets.only(
          bottom: 15
        ),
        decoration: BoxDecoration(
          color: getColorFromHex('#e21a3f'),
          // borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Spacer(),
            Icon(
              Icons.delete_sweep,
              color: Colors.white,
              size: 30
            ),
            SizedBox(width: 10,)
          ],
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15
        ),
        margin: EdgeInsets.only(
          bottom: 15
        ),
        decoration: BoxDecoration(
          color: getColorFromHex('#eeeeee')
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat('yyyy-MM-dd').format(DateTime.parse(record['date']))}',
              style: TextStyle(
                color: getColorFromHex('#555555'),
                fontSize: 17
              )
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // '攝取量',
                    T.calculatorIntakeAmount,
                    style: TextStyle(
                      fontSize: 23,
                      color: (record['amount'].round() > 500)
                      ? getColorFromHex('#e21a3f')
                      : kPrimaryColor
                    )
                  ),
                  Text(
                    // '${record['amount'].round()}毫克',
                    '${record['amount'].round()}${T.calculatorMg}',
                    style: TextStyle(
                      fontSize: 23,
                      color: (record['amount'].round() > 500)
                      ? getColorFromHex('#e21a3f')
                      : kPrimaryColor
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
