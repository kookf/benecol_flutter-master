
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';

class ProfileSmallRow extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback press;

  ProfileSmallRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
          width: double.infinity,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 1,
                color: getColorFromHex("#dedede")
              ),
            )
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Image.asset(
                  icon,
                  width: 20,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset(
                    "assets/icons/icon-12.png",
                    width: 20,
                  ),
              ),
            ],
          ),
        ),
    );
  }
}