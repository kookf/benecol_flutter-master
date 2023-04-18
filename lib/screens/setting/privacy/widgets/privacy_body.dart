import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:benecol_flutter/screens/setting/privacy/widgets/privacy_single.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyBody extends StatelessWidget {
  const PrivacyBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> privacyList = context.watch<SettingProvider>().privacyList;
    
    return SingleChildScrollView(
      child: Container(
        padding: kDefaultScreenPad,
        child: Column(
          children: List.generate(
            privacyList.length, 
            (index) => PrivacySingle(
              title: privacyList[index]['title'], 
              content: privacyList[index]['content']
            )
          )
        )
      ),
    );
  }
}
