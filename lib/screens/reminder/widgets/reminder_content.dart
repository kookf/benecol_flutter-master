
import 'package:benecol_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ReminderContent extends StatelessWidget {
  const ReminderContent({
    Key? key,
    required Map<String, dynamic>? reminderContent,
  }) : _reminderContent = reminderContent, super(key: key);

  final Map<String, dynamic>? _reminderContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: kSecondaryColor
      ),
      child: Column(
        children: [
          Html(
            data: '${_reminderContent?['title'] ?? ''}',
            style: {
              "body": Style(
                margin: EdgeInsets.zero,
                fontSize: FontSize(16)
              ),
              "h1": Style(
                color: Colors.white,
                fontSize: FontSize(18),
                fontWeight: FontWeight.w400
              )
            }
          ),
          Html(
            data: '${_reminderContent?['description'] ?? ''}',
            style: {
              "body": Style(
                margin: EdgeInsets.zero,
                fontSize: FontSize(16)
              ),
            }
          ),
          Html(
            data: '${_reminderContent?['subTitle'] ?? ''}',
            style: {
              "body": Style(
                margin: EdgeInsets.only(
                  top: 15
                ),
                fontSize: FontSize(12)
              )
            }
          ),
        ],
      )
    );
  }
}