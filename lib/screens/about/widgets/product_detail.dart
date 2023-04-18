import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/about_provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailModal extends StatefulWidget {
  int productId;

  ProductDetailModal({ 
    Key? key,
    required this.productId
  }) : super(key: key);

  @override
  _ProductDetailModalState createState() => _ProductDetailModalState();
}

class _ProductDetailModalState extends State<ProductDetailModal> {
  Map<String, dynamic>? _productDetail;
  late AppLocalizations T;

  TextStyle tableHeaderStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  TextStyle tableContentStyle = TextStyle(
    fontSize: 12,
  );

  BoxDecoration tableContentStartDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(
        width: 0.5,
        color: kPrimaryColor
      )
    )
  );
  BoxDecoration tableContentEndDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 0.5,
        color: kPrimaryColor
      )
    )
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getProductDetail(context);
    });
  }

  Future<void> getProductDetail(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<AboutProvider>().getProductDetail(context, _currentId.toString(), widget.productId);
  }
  
  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _productDetail = context.watch<AboutProvider>().productDetail;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '產品資料',
          T.aboutProductInfo,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: 
        (_productDetail != null)
        ? Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1/0.7,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                          (_productDetail !=null && _productDetail!['images'] != null)
                          ? _productDetail!['images'].length 
                          : 0, 
                          (index) => Image.network(
                            _productDetail?['images'][index] ?? ''
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_productDetail?['articles']?[0]?['title'] ?? ''}',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    )
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${_productDetail?['articles']?[0]?['paragraph'] ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: kPrimaryColor
                    )
                  )
                ),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.5)
                  },
                  children: [
                    TableRow(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 5
                          ),
                          child: Text(
                            // '營養資料',
                            T.aboutGridCol1Head,
                            style: tableHeaderStyle
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 5
                          ),
                          child: Text(
                            // '每100毫升',
                            T.aboutGridCol2Head,
                            style: tableHeaderStyle
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 5
                          ),
                          child: Text(
                            // '每瓶(65毫升)',
                            T.aboutGridCol3Head,
                            style: tableHeaderStyle
                          ),
                        ),
                      ]
                    ),
                    ...List.generate(
                      _productDetail?['facts']?.length ?? 0,
                      (index) => TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              right: 5,
                              bottom: 5
                            ),
                            decoration: (index == 0) 
                            ? tableContentStartDecoration 
                            // : (index == _productDetail!['facts'].length - 1) 
                            // ? tableContentEndDecoration 
                            : null,
                            child: Text(
                              _productDetail?['facts']?[index]?['col1'] ?? '',
                              style: tableContentStyle
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              right: 5,
                              bottom: 5
                            ),
                            decoration: (index == 0) 
                            ? tableContentStartDecoration 
                            // : (index == _productDetail!['facts'].length - 1) 
                            // ? tableContentEndDecoration 
                            : null,
                            child: Text(
                              _productDetail?['facts']?[index]?['col2'] ?? '',
                              style: tableContentStyle
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              right: 5,
                              bottom: 5
                            ),
                            decoration: (index == 0) 
                            ? tableContentStartDecoration 
                            // : (index == _productDetail!['facts'].length - 1) 
                            // ? tableContentEndDecoration 
                            : null,
                            child: Text(
                              _productDetail?['facts']?[index]?['col3'] ?? '',
                              style: tableContentStyle
                            ),
                          ),
                        ]
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 15
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        // 'RI = 參考攝入量'
                        T.aboutGridRemark1
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        // '瑞士生產'
                        T.aboutGridRemark2
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
        : SizedBox()
      )
    );
  }
}
