import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/faq.dart';
import 'package:benecol_flutter/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'faq_card.dart';

class FAQBody extends StatefulWidget {
  const FAQBody({ Key? key }) : super(key: key);

  @override
  _FAQBodyState createState() => _FAQBodyState();
}

class _FAQBodyState extends State<FAQBody> {
  int? _selected;

  void _toggleCard(i){
    setState(() {
      _selected = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FAQ> faqList = new List.from(context.watch<SettingProvider>().faqList.reversed);
    
    return Padding(
      padding: kDefaultScreenPad,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(faqList.length, 
            (index) => GestureDetector(
              onTap: (){ _toggleCard(index); },
              child: FAQCard(
                title: faqList[index].title,
                content: faqList[index].content,
                isOpened: index == _selected,
              ),
            ),
          )
        ),
      ),
    );
  }
}
