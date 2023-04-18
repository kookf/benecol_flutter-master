
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

class HealthTipsCard extends StatelessWidget {
  HealthTipsCard({
    Key? key,
    required this.title,
    required this.content,
    required this.isOpened
  }) : super(key: key);

  final String title;
  final String content;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: kGreyColor),
            ),
          ),
          child: Column(
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
                      title,
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
              if(isOpened)
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Html(
                    data: content,
                    style: {
                      "body": Style(
                        margin: EdgeInsets.zero,
                        fontSize: FontSize(16)
                      ),
                    }
                  )
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}