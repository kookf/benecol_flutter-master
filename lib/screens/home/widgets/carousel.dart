import 'dart:async';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/banner.dart';
import 'package:benecol_flutter/screens/home/widgets/slide.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required this.homeBanners,
  }) : super(key: key);

  final List<SingleBanner> homeBanners;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;
  late Timer _pageViewtimer;

  PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  void initState(){
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose(){
    super.dispose();
    _stopAutoPlay();
  }

  void _startAutoPlay(){
    _pageViewtimer = Timer.periodic(Duration(seconds: 5), (Timer timer) { 
      if( !_pageController.hasClients) return;
      if (_currentIndex < widget.homeBanners.length - 1){
        _currentIndex++;
      }else{
        _currentIndex = 0;
      }
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 150), curve: Curves.easeIn);
    });
  }

  void _stopAutoPlay(){
    _pageViewtimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        if(widget.homeBanners.length > 0)
        GestureDetector(
          onHorizontalDragDown: (DragDownDetails dragDownDetails){
            _stopAutoPlay();
          },
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (_index){
              setState(() {
                _currentIndex = _index;
              });
            },
            itemBuilder: (context, index) {
              return Slide(slideData: widget.homeBanners[index%widget.homeBanners.length], pageController: _pageController);
            }
          ),
        ),
        Dots(widget: widget, currentIndex: _currentIndex),
      ],
    );
  }
}

class Dots extends StatelessWidget {
  const Dots({
    Key? key,
    required this.widget,
    required int currentIndex,
  }) : _currentIndex = currentIndex, super(key: key);

  final Carousel widget;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getPropScreenWidth(5)),
      child: Container(
        height: getPropScreenWidth(20),
        //color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.homeBanners.length,
            (index) => Container(
              margin: EdgeInsets.only(
                left: 4, 
                right: 4
              ),
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: _currentIndex % widget.homeBanners.length == index ? kPrimaryColor : kPrimaryLightColor,
                borderRadius: BorderRadius.circular(4)
              )
            )
          ),
        ),
      ),
    );
  }
}