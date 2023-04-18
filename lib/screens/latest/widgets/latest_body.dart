
import 'package:benecol_flutter/screens/latest/widgets/latest_card.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestBody extends StatefulWidget {
  LatestBody({ Key? key }) : super(key: key);

  @override
  _LatestBodyState createState() => _LatestBodyState();
}

class _LatestBodyState extends State<LatestBody> {
  List<Map<String, dynamic>>? _latestContents;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      int _currentId = getCurrentLangId(context);
      context.read<ContentProvider>().getLatestContents(context, _currentId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppLocalizations T = AppLocalizations.of(context)!;
    _latestContents = context.watch<ContentProvider>().latestContents;
    // return SingleChildScrollView(
    //   child: Column(
    //     children: List.generate(
    //       _latestContents?.length ?? 0,
    //       (index) => LatestCard(
    //         latestContent: _latestContents![index]
    //       )
    //     )
    //   ),
    // );
    return ListView.builder(
      itemCount: _latestContents?.length ?? 0,
      cacheExtent: 5000,
      itemBuilder: (BuildContext context, int index) {
        return LatestCard(
          latestContent: _latestContents![index]
        );
      }
    );
  }
}
