
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionBody extends StatefulWidget {
  PromotionBody({ Key? key }) : super(key: key);

  @override
  _PromotionBodyState createState() => _PromotionBodyState();
}

class _PromotionBodyState extends State<PromotionBody> {
  List<Map<String, dynamic>> _promotionBooth = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      await context.read<ContentProvider>().getPromotionBooth(context, _currentId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppLocalizations T = AppLocalizations.of(context)!;
    _promotionBooth = context.watch<ContentProvider>().promotionBooth;

    return SingleChildScrollView(
      child: Column(
        children:[ 
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 15
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: kGreyColor),
              ),
            ),
            child: Column(
              children: [
                ...List.generate(
                  _promotionBooth.length, 
                  (index) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage("assets/images/share/general_bullet_point.png"),
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              '${_promotionBooth[index]['title']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 17,
                                height: 1.4
                              )
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 5,
                          right: 5
                        ),
                        child: Table(
                          columnWidths: {
                            0: FractionColumnWidth(.3),
                            1: FractionColumnWidth(.45),
                            2: FractionColumnWidth(.25)
                          },
                          children: [
                            TableRow(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: getColorFromHex('#f1eff1')
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Period',
                                    style: TextStyle(
                                      color: getColorFromHex('#888888')
                                    )
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: getColorFromHex('#f1eff1')
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                      color: getColorFromHex('#888888')
                                    )
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: getColorFromHex('#f1eff1')
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Store',
                                    style: TextStyle(
                                      color: getColorFromHex('#888888')
                                    )
                                  ),
                                ),
                              ]
                            ),
                            ...List.generate(
                              _promotionBooth[index]['booths']?.length ?? 0,
                              (jndex) => TableRow(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                      5
                                    ),
                                    child: Text(
                                      _promotionBooth[index]['booths']?[jndex]?['period'] ?? '',
                                      style: TextStyle(
                                        color: getColorFromHex('#888888')
                                      )
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                      5
                                    ),
                                    child: Text(
                                      _promotionBooth[index]['booths']?[jndex]?['name'] ?? '',
                                      style: TextStyle(
                                        color: getColorFromHex('#888888')
                                      )
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                      5
                                    ),
                                    child: Text(
                                      _promotionBooth[index]['booths']?[jndex]?['store'] ?? '',
                                      style: TextStyle(
                                        color: getColorFromHex('#888888')
                                      )
                                    ),
                                  ),
                                ]
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }

}
