import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointRecordClauseModal extends StatefulWidget {
  PointRecordClauseModal({ 
    Key? key,
  }) : super(key: key);

  @override
  _PointRecordClauseModalState createState() => _PointRecordClauseModalState();
}

class _PointRecordClauseModalState extends State<PointRecordClauseModal> {
  List<Map<String, dynamic>>? _clauseContents;
  late AppLocalizations T;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getClauseContents(context);
    });
  }

  Future<void> getClauseContents(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<SettingProvider>().getClauseContents(context, _currentId.toString());
  }
  
  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _clauseContents = context.watch<SettingProvider>().clauseContents;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '條款及細則',
          T.pointRecordClauseModalTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15
          ),
          child: Column(
            children: List.generate(_clauseContents?.length ?? 0, 
              (index) => Column(
                children: [
                  if(index != 0)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _clauseContents![index]['title'],
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 17
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Html(
                    data: _clauseContents![index]['paragraphs'],
                    style: {
                      "body": Style(
                        margin: EdgeInsets.zero,
                        fontSize: FontSize(14)
                      ),
                    }
                  )
                ],
              )
            )
          ),
        )
      )
    );
  }
}
