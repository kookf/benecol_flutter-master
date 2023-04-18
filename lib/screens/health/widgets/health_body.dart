
import 'package:benecol_flutter/providers/health_provider.dart';
import 'package:benecol_flutter/screens/health/widgets/health_header.dart';
import 'package:benecol_flutter/screens/health/widgets/health_news_card.dart';
import 'package:benecol_flutter/screens/health/widgets/health_tips_card.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HealthBody extends StatefulWidget {
  HealthBody({ Key? key }) : super(key: key);

  @override
  _HealthBodyState createState() => _HealthBodyState();
}

class _HealthBodyState extends State<HealthBody> {
  String _activeTab = 'news';
  List<Map<String, dynamic>> _news = [];
  int? _selectedNews;
  List<Map<String, dynamic>> _tips = [];
  int? _selectedTips;
  List<Map<String, dynamic>> _chols = [];
  int? _selectedChols;
  late AppLocalizations T;

  // YoutubePlayerController? _controller;

  YoutubePlayerController? _controller;
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getNews();
      getTips();
      getChols();
      setVars();
    });
  }

  setVars(){
    // AppLocalizations T = AppLocalizations.of(context)!;
    // _controller = YoutubePlayerController(
    //   initialVideoId: 'g8tetaWfdZs',
    //   flags: YoutubePlayerFlags(
    //       autoPlay: false,
    //       mute: true,
    //   ),
    // );
    _controller = YoutubePlayerController(
      initialVideoId: 'g8tetaWfdZs',
      params: YoutubePlayerParams(
          // playlist: ['g8tetaWfdZs', 'g8tetaWfdZs'], // Defining custom playlist
          // startAt: Duration(seconds: 30),
          showControls: true,
          showFullscreenButton: true,
      ),
    );
  }

  onTabClick(String tabName){
    setState(() {
      _activeTab = tabName;
    });
  }

  getNews(){
      int _currentId = getCurrentLangId(context);
      context.read<HealthProvider>().getNews(context, _currentId.toString());
  }

  getTips(){
      int _currentId = getCurrentLangId(context);
      context.read<HealthProvider>().getTips(context, _currentId.toString());
  }

  getChols(){
      int _currentId = getCurrentLangId(context);
      context.read<HealthProvider>().getChols(context, _currentId.toString());
  }

  onNewsClick(index){
    setState(() {
      _selectedNews = index;
    });
  }

  onTipsClick(index){
    setState(() {
      _selectedTips = index;
    });
  }

  onCholsClick(index){
    setState(() {
      _selectedChols = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _news = context.watch<HealthProvider>().news;
    _tips = context.watch<HealthProvider>().tips;
    _chols = context.watch<HealthProvider>().chols;

    return Column(
      children:[ 
        HealthHeader(
          onTabClick: onTabClick,
          activeTab: _activeTab
        ),
        if(_activeTab == 'news')
        Expanded(
          // child: SingleChildScrollView(
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //       left: 15,
          //       right: 15,
          //       bottom: 15
          //     ),
          //     child: Column(
          //       children: List.generate(
          //         _news.length, 
          //         (index) => GestureDetector(
          //           onTap: (){
          //             onNewsClick(index);
          //           },
          //           child: HealthNewsCard(
          //             title: _news[index]['title'], 
          //             // content: '打開',
          //             content: T.healthOpenNewsCardTxt,
          //             openLink: _news[index]['open'],
          //             isOpened: _selectedNews == index
          //           ),
          //         )
          //       ),
          //     ),
          //   ),
          // ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 15
            ),
            child: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    onNewsClick(index);
                  },
                  child: HealthNewsCard(
                    title: _news[index]['title'], 
                    // content: '打開',
                    content: T.healthOpenNewsCardTxt,
                    openLink: _news[index]['open'],
                    isOpened: _selectedNews == index
                  ),
                );
              }
            ),
          )

        ),
        if(_activeTab == 'tips')
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 15
              ),
              child: Column(
                children: List.generate(
                  _tips.length, 
                  (index) => GestureDetector(
                    onTap: (){
                      onTipsClick(index);
                    },
                    child: HealthTipsCard(
                      title: _tips[index]['title'], 
                      content: _tips[index]['content'],
                      isOpened: _selectedTips == index
                    ),
                  )
                ),
              ),
            ),
          ),
        ),
        if(_activeTab == 'chols')
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 15
              ),
              child: Column(
                children: [
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
                  ...List.generate(
                    _chols.length, 
                    (index) => GestureDetector(
                      onTap: (){
                        onCholsClick(index);
                      },
                      child: HealthTipsCard(
                        title: _chols[index]['title'], 
                        content: _chols[index]['content'],
                        isOpened: _selectedChols == index
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
}
