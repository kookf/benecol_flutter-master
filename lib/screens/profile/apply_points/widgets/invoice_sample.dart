import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:provider/provider.dart';

class InvoiceSample extends StatefulWidget {
  InvoiceSample({ 
    Key? key,
    required this.isShowCheckbox,
  }) : super(key: key);

  bool isShowCheckbox;

  @override
  State<InvoiceSample> createState() => _InvoiceSampleState();
}

class _InvoiceSampleState extends State<InvoiceSample> {
  late AppLocalizations T;
  bool isDisableAuto = false;
  List<String> _receipts = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      await context.read<ContentProvider>().getReceipts(context, _currentId.toString());
      // _receipts = await context.read<ContentProvider>().receipt;
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _receipts = context.watch<ContentProvider>().receipt;
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
    //   "assets/images/myAccount/14.jpg",
    //   "assets/images/myAccount/15.jpg",
    //   "assets/images/myAccount/16.jpg",
    // ];

    onDisableAutoClick(){
      setState(() {
        isDisableAuto = !isDisableAuto;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        // print('onInvoiceSample pop');
        if(widget.isShowCheckbox && isDisableAuto){
          LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
          _localStorageSingleton.setValue('noAutoInvoiceSample', 'yes');
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kAppBarHeight,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            // '收據樣版Sample',
            T.applyPointInoviceSampleTitle,
            style: TextStyle(
              fontSize: kAppBarFontSize
            )
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          // fit: StackFit.expand,
          children: [
            Column(
              children: [
                if(widget.isShowCheckbox)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10
                  ),
                  child: GestureDetector(
                    onTap: onDisableAutoClick,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          isDisableAuto ? Icons.check_box : Icons.check_box_outline_blank,
                          // color: Colors.white,
                          color: kPrimaryColor,
                          size: 20
                        ),
                        SizedBox(width: 5),
                        Text(
                          // '不再自動顯示',
                          T.applyPointInoviceSampleDisableAutoShow,
                          style: TextStyle(
                            // color: kPrimaryColor
                          )
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    children: [
                      ...List.generate(
                        _receipts.length, 
                        (index) => Column(
                          children: [
                            Image.network(_receipts[index])
                          ]
                        )
                      ),
                    ]
                  ),
                ),
              ],
            ),
            Positioned(
              top: SizeConfig.screenHeight / 2 - 50,
              width: SizeConfig.screenWidth,
              child: IgnorePointer(
                ignoring: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 35, 
                      height: 35,
                      child: Icon(
                        Icons.chevron_left,
                        color: kPrimaryColor,
                        size: 35
                      ),
                    ),
                    SizedBox(
                      width: 35, 
                      height: 35, 
                      child: Icon(
                        Icons.navigate_next,
                        color: kPrimaryColor,
                        size: 35
                      ),
                    )
                  ],
                ),
              )
            ),
          ]
        )
      ),
    );
  }
}