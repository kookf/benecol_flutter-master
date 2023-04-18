
import 'package:benecol_flutter/screens/store/store_search/store_search_screen.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindNearestStoreBtn extends StatelessWidget {
  FindNearestStoreBtn({
    Key? key,
  }) : super(key: key);
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: (){
        // Navigator.pushNamed(context, StoreSearchScreen.routeName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreSearchScreen(isNearby: true),
          ),
        );
      }, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // '尋找附近銷售地點',
            T.storeFindNearestStoreBtnText,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            )
          ),
        ],
      ),
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: getColorFromHex('#BBBBBB'),
        padding: EdgeInsets.symmetric(
          vertical:10,
        ),
      ),
    );
  }
}