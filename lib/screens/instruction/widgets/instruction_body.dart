
import 'package:benecol_flutter/providers/auth_provider.dart';
import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/screens/profile/profile_screen.dart';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';

class InstructionBody extends StatefulWidget {
  InstructionBody({ Key? key }) : super(key: key);

  @override
  _InstructionBodyState createState() => _InstructionBodyState();
}

class _InstructionBodyState extends State<InstructionBody> {
  Map<String, dynamic>? _instructionDetail;
  int? _currentLangId;
  late AppLocalizations T;
  late Timer _pageViewtimer;
  int _currentIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      await context.read<ContentProvider>().getInstructionDetail(context, _currentId.toString());
      setState(() {
        _currentLangId = _currentId;
      });
      _startAutoPlay();
    });
  }

  void _startAutoPlay(){
    _pageViewtimer = Timer.periodic(Duration(seconds: 5), (Timer timer) { 
      if( !_pageController.hasClients) return;
      if (_currentIndex < ((_instructionDetail?['slides']?.length ?? 0)-1)){
        _currentIndex++;
      }else{
        _currentIndex = 0;
      }
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 150), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _instructionDetail = context.watch<ContentProvider>().instructionDetail;

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    left: 5,
                    top: 19,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/instruction/in-left-top.png',
                          width: 11.6,
                        ),
                        Image.asset(
                          'assets/images/instruction/in-left.png',
                          width: 11.6,
                        )
                      ],
                    )
                  ),
                  Container(
                    width: double.infinity,
                    // height: 350,
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 15
                          ),
                          padding: EdgeInsets.only(
                            // vertical: 4,
                            // horizontal: 10
                            top: 4,
                            bottom: 4,
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                getColorFromHex('#00c8da'),
                                getColorFromHex('#009cab'),
                              ],
                            )
                          ),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Image.asset(
                                'assets/images/instruction/tu13.png'
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 30
                                ),
                                child: Text(
                                  _instructionDetail?['title'] ?? '',  
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19
                                  )
                                )
                              ),
                            ]
                          )
                        ),
                        Html(
                          data: _instructionDetail?['description'] ?? '',
                          style: {
                            "body": Style(
                              margin: EdgeInsets.zero,
                              fontSize: FontSize(16)
                            ),
                            "h2": Style(
                              fontSize: FontSize(17),
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                              padding: EdgeInsets.only(left: 15)
                            ),
                            "p": Style(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15
                              ),
                              fontSize: FontSize(15)
                            ),
                            "p.memo": Style(
                              color: getColorFromHex('#377c2b')
                            ),
                            "i": Style(
                              fontStyle: FontStyle.normal,
                            ),
                            "h2 i": Style(
                              after: '${String.fromCharCode(9654)} '
                            ),
                            "li": Style(
                              padding: EdgeInsets.only(
                                top: 0,
                                left: 5,
                                right: 10,
                                bottom: 10
                              ),
                              margin: EdgeInsets.only(
                                left: 0,
                                right: 0
                              ),
                              fontSize: FontSize(15)
                            ),
                            "ol": Style(
                              padding: EdgeInsets.all(
                                0
                              )
                            ),
                          }
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1/0.3,
                                child: PageView(
                                  controller: _pageController,
                                  children: [
                                    ...List.generate(
                                      _instructionDetail?['slides']?.length ?? 0, 
                                      (index) => Image.network(
                                        _instructionDetail!['slides'][index]['path'],
                                        fit: BoxFit.contain,
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                  ),
                  if(_currentLangId == 2) // only show this pic on chinese version
                  Positioned(
                    right: 15,
                    top: 30,
                    child: Image.asset(
                      'assets/images/instruction/E170512WK_Logo.jpg',
                      width: 110,
                    ),
                  ),
                ]
              ),
              Container(
                // decoration: BoxDecoration(
                //   color: Colors.grey
                // ),
                child: Column(
                  children: [
                    ...List.generate(
                      _instructionDetail?['items']?.length ?? 0, 
                      (index) => Container(
                        width: double.infinity,
                        child: Image.network(
                          _instructionDetail!['items'][0]['desc'],
                          fit: BoxFit.fill
                        ),
                      )
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async{
                  bool _isAuth = await context.read<AuthProvider>().isAuthenticated();
                  if(_isAuth){
                    // print('isAuth');
                    Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (route) => false);
                  }else{
                    // print('Not isAuth');
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: kSecondaryColor
                  ),
                  child: Center(
                    child: Text(
                      // '立即登記積分',
                      T.instructionApplyNow,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      )
                    )
                  ),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}
