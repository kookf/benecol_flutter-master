import 'package:benecol_flutter/providers/home_provider.dart';
import 'package:benecol_flutter/screens/home/widgets/carousel.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.08,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: getPropScreenWidth(15)),
                    child: Carousel(homeBanners: context.watch<HomeProvider>().homeBanners),
                  ),
                ),
                SizedBox(
                  child: Image.asset('assets/images/home/bannerbar.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}