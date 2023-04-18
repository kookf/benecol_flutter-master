
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

class LegalNoticeSingle extends StatelessWidget {
  const LegalNoticeSingle({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 17,
              fontWeight: FontWeight.w500
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, bottom: 20),
          child: Container(
            width: double.infinity,
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
        ),
      ],
    );
  }
}