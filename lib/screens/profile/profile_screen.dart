import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/widgets/profile_body.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key? key }) : super(key: key);
  static final routeName = 'profile';

  void getUserProfile(BuildContext context){
    context.read<UserProvider>().profile();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    getUserProfile(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.profileTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: getColorFromHex("#efefef"),
      endDrawer: AppDrawer(),
      body: ProfileBody()
    );
  }
}