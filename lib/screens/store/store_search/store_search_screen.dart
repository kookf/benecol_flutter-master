import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/store/store_search/widgets/store_search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreSearchScreen extends StatelessWidget {
  bool? isNearby;
  String? area;
  String? district;
  String? store;

  StoreSearchScreen({ 
    Key? key,
    this.isNearby,
    this.area,
    this.district,
    this.store
  }) : super(key: key);
  static final routeName = 'store_search';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '尋找結果',
          T.storeSearchScreenTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: StoreSearchBody(
        isNearby: isNearby,
        area: area,
        district: district,
        store: store
      )
    );
  }
}