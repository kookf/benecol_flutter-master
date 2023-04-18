import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/store/store_map/widgets/store_map_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreMapScreen extends StatelessWidget {
  Map<String, dynamic>? store;

  StoreMapScreen({ 
    Key? key,
    this.store
  }) : super(key: key);
  static final routeName = 'store_map';
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
          // '店鋪位置',
          T.storeMapScreenTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      // endDrawer: AppDrawer(),
      body: (store != null)
      ? StoreMapBody(store: store!)
      : Container()
    );
  }
}