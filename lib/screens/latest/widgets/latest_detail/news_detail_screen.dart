import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/latest/widgets/latest_detail/widgets/news_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetailScreen extends StatelessWidget {
  Map<String, dynamic>? news;

  NewsDetailScreen({ 
    Key? key,
    this.news
  }) : super(key: key);
  static final routeName = 'news_detail';
  late AppLocalizations T;

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '消息詳情',
          T.latestNewsDetailPageTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: (news != null)
      ? NewsDetailBody(news: news!)
      : SizedBox()
    );
  }
}