import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:benecol_flutter/services/localStorage.dart';

class CodeSample extends StatefulWidget {
  CodeSample({ 
    Key? key,
    // required this.isShowCheckbox,
  }) : super(key: key);

  // bool isShowCheckbox;

  @override
  State<CodeSample> createState() => _CodeSampleState();
}

class _CodeSampleState extends State<CodeSample> {
  late AppLocalizations T;
  bool isDisableAuto = false;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    // Map args = ModalRoute.of(context).settings.arguments;
    // List<String> templates = [
    //   "assets/images/myAccount/1.jpg",
    //   "assets/images/myAccount/2.jpg",
    //   "assets/images/myAccount/3.jpg",
    //   "assets/images/myAccount/4.jpg",
    //   "assets/images/myAccount/5.jpg",
    //   "assets/images/myAccount/6.jpg",
    //   "assets/images/myAccount/7.jpg",
    //   "assets/images/myAccount/8.jpg",
    //   "assets/images/myAccount/9.jpg",
    //   "assets/images/myAccount/11.jpg",
    //   "assets/images/myAccount/12.jpg",
    //   "assets/images/myAccount/13.jpg",
    // ];

    onDisableAutoClick(){
      setState(() {
        isDisableAuto = !isDisableAuto;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        // print('onCodeSample pop');
        if(isDisableAuto){
          LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
          _localStorageSingleton.setValue('noAutoCodeSample', 'yes');
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kAppBarHeight,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            '收據號碼Sample',
            // T.applyPointInoviceSampleTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
        ),
        backgroundColor: getColorFromHex('#1e9bb5'),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  '各超市之收據編號\n可參考收據樣版圖示',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please click on the Receipt Sample\n to refer to the receipt no. required\n for different purchase retails',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  )
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 85,
                    right: 60
                  ),
                  child: Image.asset('assets/images/myAccount/codeSample.png'),
                ),
                Container(
                  // transform: Matrix4.translationValues(0.0, -130.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10
                    ),
                    child: GestureDetector(
                      onTap: onDisableAutoClick,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isDisableAuto ? Icons.check_box : Icons.check_box_outline_blank,
                            color: Colors.white,
                            // color: kPrimaryColor,
                            size: 20
                          ),
                          SizedBox(width: 5),
                          Text(
                            // '不再自動顯示',
                            T.applyPointInoviceSampleDisableAutoShow,
                            style: TextStyle(
                              color: Colors.white
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}