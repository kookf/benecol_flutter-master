
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class UserMessageBody extends StatefulWidget {
  UserMessageBody({ Key? key }) : super(key: key);

  @override
  _UserMessageBodyState createState() => _UserMessageBodyState();
}

class _UserMessageBodyState extends State<UserMessageBody> {
  List<Map<String, dynamic>>? _userMessageList;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getUserMessageList(context);
    });
  }

  Future<void> getUserMessageList(BuildContext context) async{
    // int _currentId = getCurrentLangId(context);
    await context.read<UserProvider>().getUserMessageList(context);
  }

  void deleteUserMessage(BuildContext context, int id) async{
    Map<String, dynamic> result = await context.read<UserProvider>().deleteUserMessage(context, id);
    if(!!result['success']){ // delete success
      getUserMessageList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    _userMessageList = context.watch<UserProvider>().userMessageList;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15
        ),
        child: Column(
          children: List.generate(_userMessageList?.length ?? 0, (index) => 
            Container(
              decoration: BoxDecoration(
                color: getColorFromHex('#EEEEEE')
              ),
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 25
              ),
              margin: EdgeInsets.only(
                bottom: 2
              ),
              child: Stack(
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(
                        data: _userMessageList![index]['content'],
                        style: {
                          "body": Style(
                            margin: EdgeInsets.zero,
                            fontSize: FontSize(14)
                          ),
                        }
                      ),
                      SizedBox(height: 15),
                      Text(
                        _userMessageList![index]['createAt'],
                        style: TextStyle(
                          color: getColorFromHex('#AEB5B0'),
                          fontSize: 17
                        )
                      ),
                      SizedBox(height: 5)
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        deleteUserMessage(context, _userMessageList![index]['id']);
                      },
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: Icon(
                          Icons.delete,
                          color: kPrimaryColor,
                          size: 28,
                        )
                      ),
                    )
                  )
                ]
              ),
            )
          )
        ),
      ),
    );
  }
}