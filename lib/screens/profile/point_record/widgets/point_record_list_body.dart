
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';

class PointRecordListBody extends StatelessWidget {
  List<Map<String, dynamic>> userPointList;

  PointRecordListBody({
    required this.userPointList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(userPointList.length, 
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: index == 0 ? Radius.circular(5) : Radius.zero,
                    bottomLeft: index == userPointList.length-1 ? Radius.circular(5) : Radius.zero
                  )
                ),
                child: Center(
                  child: Text(
                    userPointList[index]['points'].toString(),
                    style: TextStyle(
                      fontSize: 17
                    )
                  ),
                )
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: index == 0 ? Radius.circular(5) : Radius.zero,
                    bottomRight: index == userPointList.length-1 ? Radius.circular(5) : Radius.zero
                  )
                ),
                child: Center(
                  child: Text(
                    userPointList[index]['endTime'].toString(),
                    style: TextStyle(
                      fontSize: 17
                    )
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
