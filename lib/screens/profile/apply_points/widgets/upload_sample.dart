import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:benecol_flutter/services/localStorage.dart';

class UploadSample extends StatefulWidget {
  UploadSample({ 
    Key? key,
    // required this.isShowCheckbox,
  }) : super(key: key);

  // bool isShowCheckbox;

  @override
  State<UploadSample> createState() => _UploadSampleState();
}

class _UploadSampleState extends State<UploadSample> {
  late AppLocalizations T;
  bool isDisableAuto = false;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    // Map args = ModalRoute.of(context).settings.arguments;

    onDisableAutoClick(){
      setState(() {
        isDisableAuto = !isDisableAuto;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        // print('onUploadSample pop');
        if(isDisableAuto){
          LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
          _localStorageSingleton.setValue('noAutoUploadSample', 'yes');
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
                  '實體超市機印收據',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    letterSpacing: 2
                  )
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Physical supermarket\n machine-printed receipt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  )
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '請確保下列內容清晰可見\nPlease make sure the following content is clearly visible',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  )
                ),
                SizedBox(
                  height: 0,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 45
                  ),
                  transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                  child: Image.asset('assets/images/myAccount/uploadSample.png'),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -130.0, 0.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                          text: '小貼士：'
                        ),
                        TextSpan(
                          text: '如果收據過長，你可摺短並保留以上內容\nIf the receipt is too long, you can shorten it and\n keep the above content'
                        )
                      ]
                    )
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -130.0, 0.0),
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