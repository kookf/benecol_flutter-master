import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/exchange_provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_form.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_form_controller.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_form_header.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeProductFormBody extends StatefulWidget {
  final arguments;

  ExchangeProductFormBody({ 
    Key? key,
    required this.arguments
  }) : super(key: key);

  @override
  _ExchangeProductFormBodyState createState() => _ExchangeProductFormBodyState();
}

class _ExchangeProductFormBodyState extends State<ExchangeProductFormBody> {
  int? _id;
  int? _quanity;
  int? _userPoint;
  int? _totalPoint;
  int? _shipmentType;
  int? _productPoint;
  int? _productQuanity;
  String? _shipmentTypeStr;
  String? _title;
  List<Map<String, dynamic>>? _pickupList;
  late AppLocalizations T;

  final ExchangeFormController exchangeFormController = ExchangeFormController();

  @override
  void initState() {
    super.initState();
    setVar();
    if(_shipmentType != null && _shipmentType != 0){
      Future.delayed(Duration.zero).then((value) async{
        getPickupAddressList(context, _shipmentType!);
      });
    }
  }

  void setVar(){
    _id = widget.arguments['id'];
    _title = widget.arguments['title'];
    _shipmentType = widget.arguments['type'];
    _userPoint = widget.arguments['userPoint'];
    _quanity = widget.arguments['selectedQuanity'];
    _productPoint = double.parse(widget.arguments['point']).toInt();
    _productQuanity = double.parse(widget.arguments['productQuanity']).toInt();
    _shipmentTypeStr = _shipmentType == 0 ? 'address' : 'not_shipment'; /* address = 快遞; not_shipment = 自取 */
    if(_quanity != null && _productPoint != null){
      _totalPoint = _quanity! * _productPoint!;
    }else{
      _totalPoint = 0;
    }
  }

  Future<void> getPickupAddressList(BuildContext context, int shipmentType) async {
    int _currentId = getCurrentLangId(context);
    await context.read<ExchangeProvider>().getPickupAddressList(context, _currentId.toString(), shipmentType);
  }
  
  Future<void> getUserPoint(BuildContext context) async {
    int _currentId = getCurrentLangId(context);
    await context.read<UserProvider>().getUserPoint(context, _currentId.toString());
  }

  void onCancelBtnClick(){
    Navigator.pop(context, false);
  }

  Future<void> onConfirmBtnClick() async {
    bool _success = false;
    _success = await exchangeFormController.submit(context);
    //call form controller to submit form and pop only if returned true
    if(_success) {
      await getUserPoint(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _pickupList = context.watch<ExchangeProvider>().pickupAddressList;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExchangeFormHeader(shipmentTypeStr: _shipmentTypeStr),
                if (_id != null && _shipmentType != null && _quanity != null && _productPoint != null && _title != null && _userPoint != null && _productQuanity != null)
                ExchangeForm(
                  id: _id!,
                  title: _title!,
                  quanity: _quanity!,
                  userPoint: _userPoint!,
                  pickupList: _pickupList,
                  shipmentType: _shipmentType!,
                  productPoint: _productPoint!,
                  productQuanity: _productQuanity!,
                  controller: exchangeFormController
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onCancelBtnClick,
                  child: Container(

                    height: 45,
                    decoration: BoxDecoration(
                      color: getColorFromHex('#eeeeee'),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // '取消',
                          T.exchangeProductFormCancelBtn,
                          style: TextStyle(
                            color: getColorFromHex('#666666')
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onConfirmBtnClick,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          T.exchangeProductFormConfirmBtn,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
