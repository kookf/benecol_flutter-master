import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/exchange_product.dart';
import 'package:benecol_flutter/providers/exchange_provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/widgets/exchange_product_card.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/widgets/exchange_product_header.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductsBody extends StatefulWidget {
  ExchangeProductsBody({ Key? key }) : super(key: key);

  @override
  _ExchangeProductsBodyState createState() => _ExchangeProductsBodyState();
}

class _ExchangeProductsBodyState extends State<ExchangeProductsBody> {
  String focusField = '';
  int? _category;
  List<Map<String, String>>? _exchangeProductCategoryList;
  List<ExchangeProduct>? _exchangeProducts;
  Map<String, dynamic>? _userPoint;
  late AppLocalizations T;

  var icon = {
  	"title":"assets/icons/icon-10.png",
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getExchangeProductCategoryList(context);
      getExchangeProducts(context, 0);
      getUserPoint(context);
    });
  }

  Future<void> getExchangeProductCategoryList(BuildContext context) async{
    int _currentId = getCurrentLangId(context);
    await context.read<ExchangeProvider>().getExchangeProductCategoryList(_currentId.toString());
  }

  Future<void> getExchangeProducts(BuildContext context, int category) async {
    int _currentId = getCurrentLangId(context);
    await context.read<ExchangeProvider>().getExchangeProducts(_currentId.toString(), category);
  }

  Future<void> getUserPoint(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<UserProvider>().getUserPoint(context, _currentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    _exchangeProductCategoryList = context.watch<ExchangeProvider>().exchangeProductCategoryList;
    _exchangeProducts = context.watch<ExchangeProvider>().exchangeProducts;
    _userPoint = context.watch<UserProvider>().userPoint;
    T = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ExchangeProductHeader(
                        icon: icon,
                        point: (_userPoint != null && _userPoint!['points'] != null) ? _userPoint!['points'].toString() : '0',
                      ),
                      (_exchangeProductCategoryList != null)
                      ? buildProductTypeSelect()
                      : SizedBox()
                    ],
                  ),
                ),
                (_exchangeProducts != null)
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
                  child: Wrap(
                    spacing: 0, // 主轴(水平)方向间距
                    runSpacing: 15, // 纵轴（垂直）方向间距
                    alignment: WrapAlignment.start, //沿主轴方向居中
                    children:
                      List.generate(
                        _exchangeProducts!.length + 1,
                        (index) => (index == _exchangeProducts!.length)
                          ? SizedBox(width: (SizeConfig.screenWidth))
                          : ExchangeProductCard(
                            product: _exchangeProducts![index],
                            userPoint: (_userPoint != null && _userPoint!['points'] != null) ? _userPoint!['points'] : 0,
                            onExchangeSuccessCallback: (){
                              getExchangeProducts(context, _category??0);
                            }
                          )
                      )
                  ),
                )
                : SizedBox()
              ],
            ),
          ),
        ),
      ],
    );
  }

  OptionSelectInput buildProductTypeSelect() {
    return OptionSelectInput(
      //--------Required--------
      // label: '兌換種類',
      label: T.exchangeProductsProductType,
      style: TextStyle(
        color: kSecondaryColor, 
        fontSize: 16
      ),
      options: _exchangeProductCategoryList != null ? _exchangeProductCategoryList! : [],
      // placeholder: '請選擇',
      placeholder: T.exchangeProductsProductTypePlaceholder,
      labelColor: Colors.black,
      placeholderColor: kSecondaryColor,
      primaryColor: getColorFromHex("#dedede"),
      indicatorColor: Colors.grey,
      secondaryColor: kSecondaryColor,
      focused: focusField == 'type',
      inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      onChangeCallback: (value){
        setState(() {
          focusField = '';
          _category = int.parse(value);
        });
        if(_category!=null){
          getExchangeProducts(context, _category!);
        }
      },
      onSavedCallback: (newValue){},
      onValidateCallback: (value){},
      onFocusCallback: (hasFocus) {
        if(hasFocus){
          setState(() {
            focusField = 'type';
          });
        }
      },
    );
  }
}

