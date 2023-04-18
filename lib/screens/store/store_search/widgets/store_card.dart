
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/store/store_map/store_map_screen.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  Map<String, dynamic> store;

  StoreCard({
    Key? key,
    required this.store
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.pushNamed(context, StoreMapScreen.routeName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreMapScreen(store: store),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15
        ),
        margin: EdgeInsets.only(
          bottom: 15
        ),
        decoration: BoxDecoration(
          color: getColorFromHex('#f1f1f1'),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.5), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Stack(
          children:[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/icons/icon-15.png",
                width: 17,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${store['storeId']}',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.2
                  ),
                ),
                Text(
                  '${store['shopName']}',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.2
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '${store['shopAddress']}',
                  style: TextStyle(
                    fontSize: 14
                  )
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}
