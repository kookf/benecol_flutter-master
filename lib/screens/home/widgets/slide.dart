import 'package:benecol_flutter/models/banner.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Slide extends StatelessWidget {
  const Slide({
    Key? key,
    required this.slideData,
    required this.pageController,
  }) : super(key: key);

  final SingleBanner slideData;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // child: Image.network(slideData.imagePath)
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            imageUrl: slideData.imagePath
          )
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: getPropScreenWidth(15), 
              right: getPropScreenWidth(15),
              bottom: getPropScreenWidth(30)
            ),
            child: Text(
              slideData.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getPropScreenWidth(20),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )
            ),
          ),
        )
      ],
    );
  }
}