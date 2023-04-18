
import 'package:benecol_flutter/providers/about_provider.dart';
import 'package:benecol_flutter/screens/about/widgets/product_detail.dart';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutBody extends StatefulWidget {
  AboutBody({ Key? key }) : super(key: key);

  @override
  _AboutBodyState createState() => _AboutBodyState();
}

class _AboutBodyState extends State<AboutBody> {
  late AppLocalizations T;
  List<Map<String, dynamic>>? _latestContents;
  Map<String, dynamic> _aboutSec0 = {};
  Map<String, dynamic> _aboutSec1 = {};
  Map<String, dynamic> _aboutSec2 = {};
  List<Map<String, dynamic>> _aboutProducts = [];

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      await context.read<AboutProvider>().getAbouts(context, _currentId.toString());
      _aboutSec1 = await context.read<AboutProvider>().aboutSec1;
      if(_aboutSec1['youtube_id'] != null) {
        setYoutube(_aboutSec1['youtube_id']);
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
          return ProductDetailModal(productId: id);
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
    _aboutSec0 = context.watch<AboutProvider>().aboutSec0;
    _aboutSec1 = context.watch<AboutProvider>().aboutSec1;
    _aboutSec2 = context.watch<AboutProvider>().aboutSec2;
    _aboutProducts = context.watch<AboutProvider>().aboutProducts;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildSection0(),
          // if(_controller != null)
          // YoutubePlayer(
          //   controller: _controller!,
          //   showVideoProgressIndicator: true,
          // ),
          if(_controller != null)
          YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
            controller: _controller!,
            child: YoutubePlayerIFrame(
              aspectRatio: 16 / 9,
            ),
          ),
          buildSection2(),
          buildProducts(),
          Padding(
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
          )
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
            T.aboutProduct,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          Column(
            children: [
              ...List.generate(
                (_aboutProducts.length / 2).ceil(),
                (rowIndex) => Row(
                  children: [
                    ...List.generate(
                      (_aboutProducts.length / 2) >= (rowIndex + 1) ? 2 : 1,
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
                              showProductDetailModal(context, _aboutProducts[rowIndex + columnIndex + (rowIndex != 0 ? 1 : 0)]['product_id']);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _aboutProducts[rowIndex + columnIndex + (rowIndex != 0 ? 1 : 0)]['name'],
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14
                                  )
                                ),
                                Image.network(
                                  _aboutProducts[rowIndex + columnIndex + (rowIndex != 0 ? 1 : 0)]['image']
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

  Padding buildSection2() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_aboutSec2['title'] ?? ''}',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 15),
          ...List.generate(
            _aboutSec2['paragraphs']?.length ?? 0,
            (index) => Html(
              data: '${_aboutSec2['paragraphs'][index]}',
              style: {
                "body": Style(
                  margin: EdgeInsets.zero,
                  fontSize: FontSize(16)
                ),
                "*": Style(
                  margin: EdgeInsets.symmetric(
                    vertical: 5
                  )
                ),
                "span": Style(
                  color: kPrimaryColor
                ),
                "a": Style(
                  color: kPrimaryColor,
                  textDecoration: TextDecoration.none
                )
              },
              onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, element) {
                if(url != null){
                  launch(url);
                }
              }
            ),
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
          Text(
            '${_aboutSec0['title'] ?? ''}',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 15),
          Text(
            '${_aboutSec0['paragraphs']?[0] ?? ''}',
            style: TextStyle(
              fontSize: 16
            )
          )
        ],
      ),
    );
  }
}
