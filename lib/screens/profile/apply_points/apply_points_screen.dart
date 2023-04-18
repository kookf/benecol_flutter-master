import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/apply_points_body.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/store_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplyPointsScreen extends StatelessWidget {
  ApplyPointsScreen({ Key? key }) : super(key: key);
  static final routeName = 'applyPoints';
  late AppLocalizations T;

  Future<void> getStores(BuildContext context) async {
    int langId = getCurrentLangId(context);
    await context.read<StoreProvider>().loadStores(langId);
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    getStores(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '登記積分',
          T.applyPointTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ApplyPointsBody()
    );
  }
}