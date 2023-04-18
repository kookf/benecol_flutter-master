
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordCard extends StatelessWidget {
  late AppLocalizations T;
  final Map<String, String> icon;
  final Map<String, dynamic> pointRecord;
  late int _currentId;

  PointRecordCard({
    Key? key,
    required this.icon,
    required this.pointRecord
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _currentId = getCurrentLangId(context);

    String _pointPrefix = 
      (pointRecord['type'] == 2)
      ? '-' 
      : (pointRecord['type'] == 0 || pointRecord['type'] == 1 && pointRecord['userApply'] != null && pointRecord['userApply']['is_pass'] != null && pointRecord['userApply']['is_pass'] == 1)
      ? '+'
      : '';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 10
      ),
      decoration: BoxDecoration(
        color: getColorFromHex('#EEEEEE')
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10
        ),
        child: Stack(
          children:[ 
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        // icon['title']!,
                        (pointRecord['type']==0) 
                        ? icon['points_0']!
                        : (pointRecord['type']==1)
                        ? icon['points_1']!
                        : (pointRecord['type']==2)
                        ? icon['points_2']!
                        : icon['points_3']!,
                        width: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${pointRecord['memo']}',
                        // '${pointRecord.toString()}',
                        style: TextStyle(
                          fontSize: 14
                        )
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                if(pointRecord['userApply'] != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    '${T.pointRecordListModalPurchaseDate} ${pointRecord['userApply']!['purchase_at']}',
                    style: TextStyle(
                      fontSize: 14
                    )
                  ),
                ),
                if(pointRecord['userApply'] != null)
                Container(
                  width: double.infinity,
                  height: (_currentId == 2) 
                    ? (pointRecord['userApply']!['chi_remark'] != null) ? null : 0
                    : (pointRecord['userApply']!['remark'] != null) ? null : 0,
                  padding: EdgeInsets.only(
                    right: 110
                  ),
                  child: Text(
                    (_currentId == 2) 
                    ? pointRecord['userApply']!['chi_remark'] ?? ''
                    : pointRecord['userApply']!['remark'] ?? '',
                    style: TextStyle(
                      fontSize: 14
                    )
                  )
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: 5,
                  ),
                  child: Text(
                    '${pointRecord['createAt']}',
                    style: TextStyle(
                      fontSize: 14
                    )
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Stack(
                children:[ 
                  Container(
                    width: 100,
                    height: 30,
                    padding: EdgeInsets.only(
                      right: 10
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ((pointRecord['flag'] == 3 && pointRecord['userApply'] != null && pointRecord['userApply']!['is_pass'] != null && pointRecord['userApply']!['is_pass'] == 1) || pointRecord['flag'] != 3)
                          ? AssetImage('assets/icons/tu6.png')
                          : (pointRecord['flag'] == 3 && pointRecord['userApply'] != null && pointRecord['userApply']!['is_pass'] != null && pointRecord['userApply']!['is_pass'] != 1 && pointRecord['userApply']!['is_pass'] != 2)
                          ? AssetImage('assets/icons/apply.png')
                          : (pointRecord['flag'] == 3 && pointRecord['userApply'] != null && pointRecord['userApply']!['is_pass'] != null && pointRecord['userApply']!['is_pass'] == 2)
                          ? AssetImage('assets/icons/no_pass.png')
                          : AssetImage('assets/icons/apply.png'),
                        fit: BoxFit.fill
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[ 
                        Text(
                          '$_pointPrefix ${pointRecord['points']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                          )
                        ),
                      ]
                    ),
                  ),
                ]
              )
            )
          ]
        ),
      ),
    );
  }
}
