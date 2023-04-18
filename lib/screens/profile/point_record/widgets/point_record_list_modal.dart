import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_card.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordListModal extends StatefulWidget {

  PointRecordListModal({ 
    Key? key,
  }) : super(key: key);

  @override
  _PointRecordListModalState createState() => _PointRecordListModalState();
}

class _PointRecordListModalState extends State<PointRecordListModal> {
  late AppLocalizations T;
  Map<String, dynamic>? _userPoint;
  List<Map<String, dynamic>>? _userPointRecordList;
  int? _hoverIndex;
  ScrollController _scrollController = ScrollController();
  bool _isLast = false;
  int _page = 1;

  var icon = {
  	"title":"assets/icons/icon-1.png",
  	"points_0":"assets/icons/tu8.png",
  	"points_1":"assets/icons/apply-icon.png",
  	"points_2":"assets/icons/icon-10.png",
  	"points_3":"assets/icons/tu9.png",
  	"money":"assets/icons/icon-money.png",
  	"money_bg":"assets/icons/tu6.png"
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getUserPointRecordList(context);
    });
    setScrollListener();
  }

  Future<Map<String, dynamic>> getUserPointRecordList(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    return await context.read<UserProvider>().getUserPointRecordList(context, _currentId.toString(), _page.toString());
  }

  void setScrollListener(){
    _scrollController.addListener(() async { 
      if(_scrollController.position.atEdge){
        if(_scrollController.position.pixels != 0){
          // at bottom Edge
          if(!_isLast){
            // print(' You are in bottom edge, go call newer data');
            setState(() {
              _page = _page +1;
            });
            Map<String, dynamic> response = await getUserPointRecordList(context);
            if(response['dataLength']==0){
              setState(() {
                _isLast = true;
              });
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _userPoint = context.watch<UserProvider>().userPoint;
    _userPointRecordList = context.watch<UserProvider>().userPointRecordList;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '積分詳情',
          T.pointRecordListModalTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: Column(
            children: [
              Row(
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
                        // '積分詳情',
                        T.pointRecordListModalHeader,
                        style: TextStyle(
                          fontSize: 17
                        ),
                      )
                    ],
                  ),
                  Text(
                    // '總積分: ${_userPoint?['points'] ?? 0}',
                    '${T.pointRecordListModalPointPrefix}${_userPoint?['points'] ?? 0}',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 17
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              // Column(
              //   children: List.generate(_userPointRecordList?.length ?? 0, 
              //     (index) => PointRecordCard(
              //       icon: icon,
              //       pointRecord: _userPointRecordList![index],
              //     ),
              //   ),
              // )
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _userPointRecordList?.length ?? 0,
                itemBuilder: (context, index) {
                  return PointRecordCard(
                    icon: icon,
                    pointRecord: _userPointRecordList![index],
                  );
                }
              )
            ],
          ),
        ),
      )
    );
  }
}
