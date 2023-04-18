
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/setting/widgets/setting_body.dart';
import 'package:flutter/material.dart';

class GeneralRowWithIcon extends StatelessWidget {
  GeneralRowWithIcon({
    Key? key,
    required this.text,
    required this.image,
    required this.press,
  }) : super(key: key);

  final TextStyle primaryTextStyle = SettingBody.PRIMARY_TEXT_STYLE;
  final TextStyle secondaryTextStyle = SettingBody.SECONDARY_TEXT_STYLE;

  final String text;
  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        // height: getPropScreenWidth(45),
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryColor,
              width: 0.5
            ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage(image),
                    color: kPrimaryColor,
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: primaryTextStyle
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}