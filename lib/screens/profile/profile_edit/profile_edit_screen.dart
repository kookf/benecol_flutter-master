import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/profile_edit/widgets/profile_edit_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({ Key? key }) : super(key: key);
  static final routeName = 'profile_edit';
  bool _isLoad = false;

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late AppLocalizations T;

  Future<void> getUserProfile(BuildContext context) async {
    if(widget._isLoad != true){
      await context.read<UserProvider>().profile();
      setState(() {
        widget._isLoad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    getUserProfile(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          T.profileEditTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      body: widget._isLoad ? ProfileEditBody() : Container()
    );
  }
}