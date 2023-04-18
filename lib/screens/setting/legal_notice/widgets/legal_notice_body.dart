import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/legal_notice/widgets/legal_notice_single.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LegalNoticeBody extends StatelessWidget {
  const LegalNoticeBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> legalNoticeList = context.watch<SettingProvider>().legalNoticeList;
    
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: List.generate(
            legalNoticeList.length, 
            (index) => LegalNoticeSingle(
              title: legalNoticeList[index]['title'], 
              content: legalNoticeList[index]['content']
            )
          )
        )
      ),
    );
  }
}