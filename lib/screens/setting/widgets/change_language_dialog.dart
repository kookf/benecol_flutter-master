
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/locale_provider.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChangeLanguageDialog extends StatelessWidget {
  ChangeLanguageDialog({
    Key? key
  }) : super(key: key);

  Color borderColor = getColorFromHex('#d9d9d9');
  // double titleFontSize = getPropScreenWidth(14);
  // double contentFontSize = getPropScreenWidth(14);
  // double actionFontSize = getPropScreenWidth(16);
  double titleFontSize = 14;
  double contentFontSize = 14;
  double actionFontSize = 16;

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    var lang = context.read<LocaleProvider>().locale?.toString() ?? Localizations.localeOf(context).toString();
    return StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          title: Center(
            child: Text(
              T.changeLanguageDialogTitle,
              style: TextStyle(
                fontSize: titleFontSize
              )
            )
          ),
          titlePadding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.17
          ),
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5, color: borderColor),
                  bottom: BorderSide(width: 0.5, color: borderColor)
                )
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState((){
                        lang = 'en';
                      });
                      // context.read<LocaleProvider>().setLocale(Locale('en'));
                    },
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [ 
                            Text(
                              'English',
                              style: TextStyle(
                                color: lang == 'en' ? kPrimaryColor : Colors.black,
                                fontSize: contentFontSize,
                              )
                            ),
                            if(lang == 'en')
                            SizedBox(
                              width: 17,
                              height: 17,
                              child: Icon(
                                Icons.check,
                                color: kPrimaryColor,
                                size: 17
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState((){
                        lang = 'zh_Hant';
                      });
                    },
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [ 
                            Text(
                              '繁體中文',
                              style: TextStyle(
                                color: lang == 'zh_Hant' ? kPrimaryColor : Colors.black,
                                fontSize: contentFontSize,
                              )
                            ),
                            if(lang == 'zh_Hant')
                            SizedBox(
                              width: 17,
                              height: 17,
                              child: Icon(
                                Icons.check,
                                color: kPrimaryColor,
                                size: 17
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){ 
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15)),
                      ),
                      child: Center(
                        child: Text(
                          T.changeLanguageDialogCancel,
                          style: TextStyle(
                            fontSize: actionFontSize,
                            color: kPrimaryColor,
                          )
                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  width: .5,
                  height: 45,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: getColorFromHex('#d9d9d9')
                    )
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context, lang);
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:BorderRadius.only(bottomRight: Radius.circular(15))
                      ),
                      child: Center(
                        child: Text(
                          T.changeLanguageDialogConfirm,
                          style: TextStyle(
                            fontSize: actionFontSize,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          )
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }
    );
  }
}
