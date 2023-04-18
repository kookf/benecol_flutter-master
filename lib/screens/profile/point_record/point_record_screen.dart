import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/point_record/widgets/point_record_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordScreen extends StatelessWidget {
  PointRecordScreen({ Key? key }) : super(key: key);
  static final routeName = 'point_record';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash/splash_background31.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kAppBarHeight,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            // '積分記錄',
            T.pointRecordTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: PointRecordBody()
      ),
    );
  }
}