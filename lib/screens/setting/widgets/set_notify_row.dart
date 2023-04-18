import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/widgets/setting_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetNotifyRow extends StatelessWidget {
  SetNotifyRow({
    Key? key,
    required this.press,
  }) : super(key: key);

  final TextStyle primaryTextStyle = SettingBody.PRIMARY_TEXT_STYLE;
  final TextStyle secondaryTextStyle = SettingBody.SECONDARY_TEXT_STYLE;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        // height: getPropScreenWidth(45),
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryColor,
              width: 0.5,
            )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                T.notificationTitle,
                style: primaryTextStyle
              ),
              Row(
                children: [
                  Text(
                    context.watch<SettingProvider>().notificationStatus 
                    ? T.notifyRowStatusOn 
                    : T.notifyRowStatusOff,
                    style: secondaryTextStyle
                  ),
                  SizedBox(width: 10),
                  ImageIcon(
                    AssetImage("assets/icons/icon-7.png"),
                    color: Colors.grey,
                    size: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}