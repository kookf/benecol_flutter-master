
import 'package:benecol_flutter/providers/about_oat_provider.dart';
import 'package:benecol_flutter/screens/about_oat/widgets/oat_product_detail.dart';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AboutOatBody extends StatefulWidget {
  AboutOatBody({ Key? key }) : super(key: key);

  @override
  _AboutOatBodyState createState() => _AboutOatBodyState();
}

class _AboutOatBodyState extends State<AboutOatBody> {
  late AppLocalizations T;
  List<Map<String, dynamic>>? _latestContents;
  Map<String, dynamic> _aboutOatSec0 = {};
  Map<String, dynamic> _aboutOatSec1 = {};
  Map<String, dynamic> _aboutOatSec2 = {};
  Map<String, dynamic> _aboutOatSec3 = {};
  Map<String, dynamic> _aboutOatSec4 = {};
  Map<String, dynamic> _aboutOatSec5 = {};
  Map<String, dynamic> _aboutOatSec6 = {};
  Map<String, dynamic> _aboutOatSec7 = {};
  List<Map<String, dynamic>> _aboutOatProducts = [];

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      await context.read<AboutOatProvider>().getAboutOats(context, _currentId.toString());
      _aboutOatSec1 = await context.read<AboutOatProvider>().aboutOatSec1;
      if(_aboutOatSec1['youtube_id'] != null) {
        setYoutube(_aboutOatSec1['youtube_id']);
      }
    });
  }

  setYoutube(String videoId){
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
      ),
    );
  }

  void showProductDetailModal(BuildContext context, int id){
    // print('showProductDetailModal of id : $id');
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return OatProductDetailModal(productId: id);
        },
        fullscreenDialog: true,
      ),
    );
  }
  void showLearnMore(){
    String _currentLangCode = getCurrentLangCode(context);
    String _link = "";

    if(_currentLangCode == "en"){
      _link = "http://www.benecol.com.hk/en/";
    }else{
      _link = "http://www.benecol.com.hk/zh-hk/";
    }

    launch(_link);
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _aboutOatSec0 = context.watch<AboutOatProvider>().aboutOatSec0;
    _aboutOatSec1 = context.watch<AboutOatProvider>().aboutOatSec1;
    _aboutOatSec2 = context.watch<AboutOatProvider>().aboutOatSec2;
    _aboutOatSec3 = context.watch<AboutOatProvider>().aboutOatSec3;
    _aboutOatSec4 = context.watch<AboutOatProvider>().aboutOatSec4;
    _aboutOatSec5 = context.watch<AboutOatProvider>().aboutOatSec5;
    _aboutOatSec6 = context.watch<AboutOatProvider>().aboutOatSec6;
    _aboutOatSec7 = context.watch<AboutOatProvider>().aboutOatSec7;
    _aboutOatProducts = context.watch<AboutOatProvider>().aboutOatProducts;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildSection0(), //Image or Youtube
          buildSection1(), 
          buildSection2(), //Image
          buildSection3(),
          buildSection4(), //Image
          buildSection5(),
          buildSection6(), //Image
          buildSection7(),
          buildProducts(),
          buildMoreBtn()
        ]
      ),
    );
  }

  Padding buildProducts() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // '倍樂醇產品',
            T.aboutOatProduct,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          Column(
            children: [
              ...List.generate(
                (_aboutOatProducts.length / 2).ceil(),
                (rowIndex) => Row(
                  children: [
                    ...List.generate(
                      (_aboutOatProducts.length / 2) >= (rowIndex + 1) ? 2 : 1,
                      (columnIndex) => Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: (){
                              //openProductPage
                              showProductDetailModal(context, _aboutOatProducts[rowIndex + columnIndex + (rowIndex != 0 ? 1 : 0)]['product_id']);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _aboutOatProducts[rowIndex + columnIndex + (rowIndex != 0 ? 1 : 0)]['name'],
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14
                                  )
                                ),
                                Image.network(
                                  _aboutOatProducts[rowIndex + columnIndex + (rowIndex != 0 ? 1 : 0)]['image']
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    )
                  ],
                ) 
              )
            ],
          )
        ],
      ),
    );
  }

  Padding buildSection7() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${_aboutOatSec7['paragraphs']?[0] ?? ''}',
                    style: TextStyle(
                      fontSize: 16
                    )
                  ),
                ),
              ],
            )
          ],
      ),
    );
  }

  Padding buildSection6() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _aboutOatSec6['image'] != null 
            ? Image.network(
              _aboutOatSec6['image'],
              width: double.infinity,
              fit: BoxFit.cover,
            )
            : SizedBox(),
          ],
      ),
    );
  }

  Padding buildSection5() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_aboutOatSec5['title'] ?? ''}',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 15),
          Text(
            '${_aboutOatSec5['paragraphs']?[0] ?? ''}',
            style: TextStyle(
              fontSize: 16
            )
          )
        ],
      ),
    );
  }

  Padding buildSection4() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _aboutOatSec4['image'] != null 
          ?
          Image.network(
            _aboutOatSec4['image']
          )
          :
          SizedBox()
        ],
      ),
    );
  }

  Padding buildSection3() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_aboutOatSec3['title'] ?? ''}',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 15),
          Text(
            '${_aboutOatSec3['paragraphs']?[0] ?? ''}',
            style: TextStyle(
              fontSize: 16
            )
          )
        ],
      ),
    );
  }

  Padding buildSection2() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _aboutOatSec2['image'] != null 
          ?
          Image.network(
            _aboutOatSec2['image']
          )
          :
          SizedBox()
        ],
      ),
    );
  }

  Padding buildSection1() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_aboutOatSec1['title'] ?? ''}',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 15),
          Text(
            '${_aboutOatSec1['paragraphs']?[0] ?? ''}',
            style: TextStyle(
              fontSize: 16
            )
          )
        ],
      ),
    );
  }

  Padding buildSection0() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_controller != null)
          ?
          YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
            controller: _controller!,
            child: YoutubePlayerIFrame(
              aspectRatio: 16 / 9,
            ),
          )
          : _aboutOatSec0['image'] != null 
          ?
            Image.network(
              _aboutOatSec0['image']
            )
          :
          SizedBox()
        ],
      ),
    );
  }

  Padding buildMoreBtn() {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15
      ),
      child: TextButton(
        onPressed: (){
          showLearnMore();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // '更多倍樂醇資訊',
              T.aboutPageMoreTxt,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              )
            ),
          ],
        ),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: kSecondaryColor,
          padding: EdgeInsets.symmetric(
            vertical:10,
          ),
        ),
      ),
    );
  }
}
