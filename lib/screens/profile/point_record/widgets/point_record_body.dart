
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_clause_modal.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_header.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_list_body.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_list_footer.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_list_header.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_list_modal.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PointRecordBody extends StatefulWidget {
  PointRecordBody({ Key? key }) : super(key: key);

  @override
  _PointRecordBodyState createState() => _PointRecordBodyState();
}

class _PointRecordBodyState extends State<PointRecordBody> {
  late AppLocalizations T;
  Map<String, dynamic>? _userPoint;
  List<Map<String, dynamic>>? _userPointList;
  var icon = {
  	"title":"assets/icons/icon-9.png"
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getUserPoint(context);
    });
  }

  void showPointRecordModal(BuildContext context){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return PointRecordListModal();
        },
        fullscreenDialog: true,
      ),
    );
  }

  void showClauseModal(BuildContext context){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return PointRecordClauseModal();
        },
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> getUserPoint(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<UserProvider>().getUserPoint(context, _currentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _userPoint = context.watch<UserProvider>().userPoint;
    _userPointList = context.watch<UserProvider>().userPointList;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15
              ),
              child: Column(
                children: [
                  PointRecordHeader(
                    icon: icon,
                    userPoint: _userPoint?['points'] ?? 0
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45
                        ),
                        PointRecordListHeader(),
                        PointRecordListBody(
                          userPointList: _userPointList ?? []
                        ),
                        PointRecordListFooter(
                          lastDay: _userPoint?['lastDay'] ?? ''
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showPointRecordModal(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor
                    ),
                    child: Center(
                      child: Text(
                        // '積分詳情',
                        T.pointRecordDetail,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        )
                      ),
                    ),
                  ),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showClauseModal(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSecondaryColor
                    ),
                    child: Center(
                      child: Text(
                        // '條款及細則',
                        T.pointRecordClause,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        )
                      ),
                    ),
                  ),
                )
              )
            ],
          ),
        )
      ],
    );
  }
}

