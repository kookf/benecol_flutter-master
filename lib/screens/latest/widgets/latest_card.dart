
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/latest/widgets/latest_detail/news_detail_screen.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LatestCard extends StatelessWidget {
  const LatestCard({
    Key? key,
    required Map<String, dynamic> latestContent,
  }) : _latestContent = latestContent, super(key: key);

  final Map<String, dynamic> _latestContent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            NewsDetailScreen(news: _latestContent)
          )
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: 10
        ),
        decoration: BoxDecoration(
          color: kSecondaryColor,
        ),
        child: Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: 
              _latestContent['image'] != null
              // ? Image.network(
              //   _latestContent['image'] ?? '',
              // )
              ? CachedNetworkImage(
                fadeInDuration: Duration.zero,
                imageUrl: _latestContent['image'] ?? ''
              )
              : SizedBox()
            ),
            Positioned(
              bottom: 15,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10
                ),
                child: Text(
                  _latestContent['title'] ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
