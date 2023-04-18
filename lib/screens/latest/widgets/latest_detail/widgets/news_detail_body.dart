
import 'package:flutter/gestures.dart';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailBody extends StatefulWidget {
  Map<String, dynamic> news;

  NewsDetailBody({ 
    Key? key,
    required this.news
  }) : super(key: key);

  @override
  _NewsDetailBodyState createState() => _NewsDetailBodyState();
}

class _NewsDetailBodyState extends State<NewsDetailBody> {
  late AppLocalizations T;
  Map<String, dynamic>? _newsDetail;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      context.read<ContentProvider>().getNewsDetail(context, _currentId.toString(), widget.news['id'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _newsDetail = context.watch<ContentProvider>().newsDetail;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: List.generate(
                _newsDetail?['images']?.length ?? 0,
                (index) => CachedNetworkImage(
                  imageUrl: _newsDetail?['images'][index]
                )
              )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15
            ),
            child: Column(
              children: List.generate(
                _newsDetail?['articles']?.length ?? 0,
                (index) => Column(
                  children: [
                    Html(
                      data: _newsDetail?['articles'][index]['title'] ?? '',
                      style: {
                        "body": Style(
                          margin: EdgeInsets.zero,
                          fontSize: FontSize(16)
                        )
                      }
                    ),
                    Html(
                      data: _newsDetail?['articles'][index]['paragraph'] ?? '',
                      style: {
                        "body": Style(
                          margin: EdgeInsets.zero,
                          // padding: EdgeInsets.zero,
                          fontSize: FontSize(16)
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 20
                      ),
                      child: RichText(
                        text: TextSpan(
                          // text: '詳情請瀏覽倍樂醇 Facebook專頁',
                          text: T.latestNewsDetailBodyLinkText,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16
                          ),
                          recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            launch('${_newsDetail?['articles'][index]['url']}');
                          }
                        ),
                      ),
                    )
                  ],
                )
              )
            ),
          ),
          // Text('${_newsDetail?['articles'][0] ?? ''}'),
        ],
      ),
    );
  }
}
