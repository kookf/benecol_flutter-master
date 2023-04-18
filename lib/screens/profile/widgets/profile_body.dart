import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/profile.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/apply_points/apply_points_screen.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_products_screen.dart';
import 'package:benecol_flutter/screens/profile/point_record/point_record_screen.dart';
import 'package:benecol_flutter/screens/profile/user_message/user_message_screen.dart';
import 'package:benecol_flutter/screens/profile/widgets/profile_small_row.dart';
import 'package:benecol_flutter/screens/profile/profile_edit/profile_edit_screen.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({ Key? key }) : super(key: key);
  late AppLocalizations T;

  var icon = {
  	"profile":"assets/icons/icon-8.png",
  	"member_points":"assets/icons/icon-9.png",
  	"apply_points":"assets/icons/icon-1.png",
  	"exchange_products":"assets/icons/icon-10.png",
  	"user_message":"assets/icons/icon-11.png"
  };

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Column(
      children: [
        buildProfileRow(context),
        buildPointRecordRow(context),
        buildPointApplyRow(context),
        buildExchangeProductsRow(context),
        buildDivider(),
        buildUserMessageRow(context),
      ],
    );
  }

  Padding buildProfileRow(BuildContext context) {
    Profile userProfile = context.watch<UserProvider>().userProfile;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 1,
                color: getColorFromHex("#dedede")
              ),
              bottom: BorderSide(
                width: 1,
                color: getColorFromHex("#dedede")
              ),
            )
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  icon['profile']!,
                  width: 50,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          '${userProfile.firstName} ${userProfile.lastName}',
                          style: TextStyle(
                            fontSize: 16
                          ),
                        )
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          '${userProfile.phone}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14
                          )
                        )
                      )
                    ],
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, ProfileEditScreen.routeName);
                  }, 
                  child: Text(
                    T.profileEditRowMore,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 13
                    )
                  )
                ),
              )
            ],
          ),
        ),
      );
  }

  ProfileSmallRow buildPointRecordRow(BuildContext context) {
    return ProfileSmallRow(
      icon: icon['member_points']!,
      text: T.profileMemberPointsTitle,
      press: (){
        Navigator.pushNamed(context, PointRecordScreen.routeName);
      }
    );
  }

  ProfileSmallRow buildPointApplyRow(BuildContext context) {
    return ProfileSmallRow(
      icon: icon['apply_points']!,
      text: T.profileApplyPointsTitle,
      press: (){
        Navigator.pushNamed(context, ApplyPointsScreen.routeName);
      }
    );
  }

  ProfileSmallRow buildExchangeProductsRow(BuildContext context) {
    return ProfileSmallRow(
      icon: icon['exchange_products']!,
      text: T.profileExchangeProductTitle,
      press: (){
        Navigator.pushNamed(context, ExchangeProductsScreen.routeName);
      }
    );
  }

  ProfileSmallRow buildUserMessageRow(BuildContext context) {
    return ProfileSmallRow(
      icon: icon['user_message']!,
      text: T.profileUserMessageTitle,
      press: (){
        Navigator.pushNamed(context, UserMessageScreen.routeName);
      }
    );
  }

  SizedBox buildDivider() {
    return SizedBox(
        width: double.infinity,
        height:16,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width:1,
                color: getColorFromHex("#dedede"),
              )
            )
          ),
        ),
      );
  }
}
