import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }else {
    return Colors.black;
  }
}

int getCurrentLangId(BuildContext context){
  String langCode = Localizations.localeOf(context).toString();
  return getLangId(langCode);
}
String getCurrentLangCode(BuildContext context){
  String langCode = Localizations.localeOf(context).toString();
  return langCode;
}

final RegExp emailRegExp = RegExp(r"^[a-z0-9!#$%&'*+\/=?^_`{|}~.-]+@[a-z0-9]([a-z0-9-]*[a-z0-9])?(\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)*$");
final RegExp phoneRegExp = RegExp(r"^[23456789][0-9]{7}$");

void textDialog({required BuildContext context, String content = '', bool dismissable = true}) {
  showDialog(
    barrierDismissible: dismissable,
    context: context,
    builder: (context){
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.2
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getPropScreenWidth(20), 
            horizontal: getPropScreenWidth(10)
          ),
          child: Text(
            content,
            textAlign: TextAlign.center
          ),
        ),
      );
    }
  );
}

void showNoIconMessageDialog(String $message) {
  EasyLoading.show(
    status: $message,
    indicator: SizedBox(height:0),
    dismissOnTap: true
  );
}

void showSheet(BuildContext context, { 
    required Widget child, 
    required VoidCallback onClicked,
    required String actionText,
    Function? onDismiss,
    Function(bool)? onFocusChange
  }) {
  showCupertinoModalPopup(
    context: context, 
    builder: (context) => WillPopScope(
      onWillPop: () async {
        if(onDismiss != null){
          onDismiss();
        }
        if(onFocusChange != null){
          onFocusChange(false);
        }
        return true;
      },
      child: CupertinoActionSheet(
        actions: [
          child
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            actionText,
            style: TextStyle(
              color: kPrimaryColor
            )
          ),
          onPressed: onClicked,
        ),
      ),
    )
  );
}

Future<dynamic> showAlertDialogWithOnlyConfirm(BuildContext context, { String? title, String? content, String? actionText, VoidCallback? action}){
  return showCupertinoDialog(
    context: context, 
    builder: (context) => CupertinoAlertDialog(
      title: (title!=null) ? Text(title) : null,
      content: (content!=null) ? Text(content) : null,
      actions: [
        CupertinoDialogAction(
          child: Text(
            (actionText!=null)?actionText:'Confirm',
            style: TextStyle(
              color: kPrimaryColor
            )
          ),
          onPressed: action ?? () => Navigator.of(context).pop(true)
        )
      ],
    )
  );
}

Future<dynamic> showAlertDialogWithConfirmAndCancel(BuildContext context, { String? title, String? content, String? confirmActionText, String? cancelActionText }){
  return showCupertinoDialog(
    context: context, 
    builder: (context) => CupertinoAlertDialog(
      title: (title!=null) ? Text(title) : null,
      content: (content!=null) ? Text(content) : null,
      actions: [
        CupertinoDialogAction(
          child: Text(
            (cancelActionText!=null)?cancelActionText:'Cancel',
            style: TextStyle(
              color: kDangerColor
            )
          ),
          onPressed: () => Navigator.of(context).pop(false)
        ),
        CupertinoDialogAction(
          child: Text(
            (confirmActionText!=null)?confirmActionText:'Confirm',
            style: TextStyle(
              color: kPrimaryColor
            )
          ),
          onPressed: () => Navigator.of(context).pop(true)
        )
      ],
    )
  );
}