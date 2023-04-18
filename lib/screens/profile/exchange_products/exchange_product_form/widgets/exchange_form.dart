import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/exchange_provider.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_address_select.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/exchange_form_controller.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeForm extends StatefulWidget {
  int id;
  int quanity;
  String title;
  int userPoint;
  int shipmentType;
  int productPoint;
  int productQuanity;
  List<Map<String, dynamic>>? pickupList;
  ExchangeFormController controller;
  ExchangeForm({ 
    Key? key,
    this.pickupList,
    required this.id,
    required this.title,
    required this.quanity,
    required this.userPoint,
    required this.controller,
    required this.shipmentType,
    required this.productPoint,
    required this.productQuanity
  }) : super(key: key);

  @override
  _ExchangeFormState createState() => _ExchangeFormState(controller);
}

class _ExchangeFormState extends State<ExchangeForm> {
  bool submited = false;
  String focusField = '';
  List<String> errors = [];
  late Map<String, String> errorMap;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController totalPointFieldController;
  late AppLocalizations T;

  String _name = '';
  int _quanity = 0;
  int _point = 0;
  int _totalPoint = 0;
  int _userPoint = 0;
  int _productQuanity = 0;
  //shipment required 
  Map<String, dynamic> _address = {};
  //pickup required
  String _cardName = '';
  String _cardNum = '';
  String _pickupCentre = '';

  Map<String, dynamic>? _tempPickupCentre;

  var icon = {
		"title": "assets/icons/icon-9.png",
		"card_name": "assets/icons/icon-14.png",
		"address": "assets/icons/icon-15.png",
		"phone": "assets/icons/icon-16.png",
		'card_num': "assets/icons/id_num.png",
		'shop': "assets/icons/shop_address.png",
	};

  _ExchangeFormState(ExchangeFormController _controller) {
    _controller.submit = submit;
  }

  @override
  void initState() {
    // print('[ExchangeForm] initState shipmentType: ${widget.shipmentType}');
    void setVar(){
      _name = widget.title;
      _quanity = widget.quanity;
      _point = widget.productPoint;
      _userPoint = widget.userPoint;
      _totalPoint = _quanity * _point;
      _productQuanity = widget.productQuanity;
    }
    totalPointFieldController = new TextEditingController(text: (widget.productPoint * widget.quanity).toString());
    setVar();
    super.initState();
  }

  void setSubmitted(){
    setState(() {
      submited = true;
    });
  }

  void updatePickupCentre(int id){
    if(widget.pickupList == null) return;
    Map<String, dynamic> _selected = widget.pickupList!.firstWhere((element){ 
      return element['id'] == id;
    });
    setState(() {
      _tempPickupCentre = _selected;
    });
  }

  Future<bool> submit(BuildContext context) async{
    // print('[ExchangeForm] submit');
    setSubmitted();
    if(_formKey.currentState == null ) return false;
    if(!_formKey.currentState!.validate()){
      return false;
    }
    _formKey.currentState!.save();
    bool _isNotEnoughPoint,
      _isNotEnoughQuanity;

    _isNotEnoughPoint = _userPoint < _totalPoint;
    _isNotEnoughQuanity = _productQuanity < _quanity;

    if(_isNotEnoughPoint){
      // String _message = '抱歉，您的積分不足夠兌換該禮品，請重新選擇。';
      String _message = T.exchangeProductFormNotEnoughPointErrorMessage;
      // await showAlertDialogWithOnlyConfirm(context, content: _message, actionText: '確認');
      await showAlertDialogWithOnlyConfirm(context, content: _message, actionText: T.exchangeProductFormDialogConfirm);
      return false;
    }

    if(_isNotEnoughQuanity){
      // String _message = '抱歉，兌換該禮品的数量不足夠，請重新選擇。';
      String _message = T.exchangeProductFormNotEnoughQuanityErrorMessage;
      // await showAlertDialogWithOnlyConfirm(context, content: _message, actionText: '確認');
      await showAlertDialogWithOnlyConfirm(context, content: _message, actionText: T.exchangeProductFormDialogConfirm);
      return false;
    }

    // call exchange api
    Map<String, dynamic> _sendObj = {};
    if(widget.shipmentType == 0){ // by post
      _sendObj['name'] = _address['name'];
      _sendObj['address'] = _address['address'];
      _sendObj['phone'] = _address['phone'];
      _sendObj['shop_id'] = '';
      _sendObj['card_num'] = '';
    }else {
      //shipmentType 1 or != 0
      _sendObj['name'] = _cardName;
      _sendObj['address'] = '';
      _sendObj['phone'] = '';
      _sendObj['shop_id'] = _pickupCentre;
      _sendObj['card_num'] = _cardNum;
    }
    _sendObj['shipment_type'] = widget.shipmentType;
    _sendObj['id'] = widget.id;
    _sendObj['quanity'] = _quanity;
    _sendObj['lang'] = getCurrentLangId(context);

    // print('_sendObj :$_sendObj');

    Map<String, dynamic> res;
    res = await context.read<ExchangeProvider>().addOrder(context, _sendObj);
    if(res['success'] == true){
      String _successMessage = T.exchangeProductFormSuccessMessage;
      if(widget.shipmentType == 0){
        _successMessage = T.exchangeProductFormSuccessByPostMessage;
      }else if(widget.shipmentType == 2){
        _successMessage = T.exchangeProductFormSuccessByShopMessage;
      }

      await showAlertDialogWithOnlyConfirm(
        context,
        content: _successMessage,
        // actionText: '確認'
        actionText: T.exchangeProductFormDialogConfirm
      );
      return true;
    }else{
      await showAlertDialogWithOnlyConfirm(
        context,
        // content: '兌換出錯！',
        content: T.exchangeProductFormDefaultErrorMessage,
        // actionText: '確認'
        actionText: T.exchangeProductFormDialogConfirm
      );
      return false;
    }
  }

  void addError(errorType){
    if(errors.contains(errorType)) return;
    setState(() {
      errors.add(errorType);
    });
  }
  void removeError(errorType){
    if(!errors.contains(errorType)) return;
    setState(() {
      errors.remove(errorType);
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    errorMap = {
      // "ADDRESS_ERROR": '請輸入地址',
      "ADDRESS_ERROR": T.exchangeProductFormAddressError,
      // "CARD_NAME_ERROR": '請輸入換領人姓名',
      "CARD_NAME_ERROR": T.exchangeProductFormCardNameError,
      // "CARD_NUM_ERROR": '請輸入身份證前3位數字',
      "CARD_NUM_ERROR": T.exchangeProductFormCardNumError,
      // "PICKUP_CENTRE_ERROR": '請選擇自取禮品的店鋪'
      "PICKUP_CENTRE_ERROR": T.exchangeProductFormPickupCentreError
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15
      ),
      child: Column(
        children: [
          buildProductNameField(),
          buildExchangeQuanityField(),
          buildPointField(),
          buildTotalPointField(),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 20,
                          bottom: 10
                        ),
                        child: Text(
                          // "請填寫資料，確認兌換產品",
                          T.exchangeProductFormRemark,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17 
                          )
                        ),
                      ),
                      (widget.shipmentType == 0)
                      ? buildShipmentFields()
                      : buildPickupFields()
                    ],
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Column buildShipmentFields() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            // "*請在下方填寫相關資料並細心確認，一經送出將不能更改。",
            T.exchangeProductFormShipmentRemark,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14
            )
          ),
        ),
        Container(
          width: double.infinity,
          child: ExchangeAddressSelectInput(
            //--------Required--------
            // label: '郵寄地址',
            label: T.exchangeProductFormAddressFieldLabel,
            style: TextStyle(
              color: kSecondaryColor, 
              fontSize: 16
            ),
            options: [],
            labelIcon: Padding(
              padding: EdgeInsets.only(left: 0, right: 10),
              child: Image.asset(
                icon['address']!,
                width: 20,
              ),
            ),
            labelColor: kPrimaryColor,
            primaryColor: getColorFromHex("#dedede"),
            indicatorColor: Colors.grey,
            secondaryColor: kSecondaryColor,
            focused: focusField == 'address',
            // placeholder: '添加地址',
            placeholder: T.exchangeProductFormAddressFieldPlaceholder,
            placeholderColor: Colors.grey,
            inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            onChangeCallback: (value){
              // print('[ExchangeForm] address field onChange');
              if(!submited) return;
              if(value != null && value.isNotEmpty) removeError("ADDRESS_ERROR");
            },
            onSavedCallback: (newValue){
              // print('[ExchangeForm] address field onSave $newValue');
              _address = newValue!;
            },
            onValidateCallback: (value){
              // print('[ExchangeForm] Address field onValidate');
              if(value == null || value.isEmpty) {
                addError("ADDRESS_ERROR");
                return '';
              }
              return null;
            },
            onFocusCallback: (hasFocus) {},
          ),
        ),
        buildFieldError('ADDRESS_ERROR'),
      ],
    );
  }

  Column buildPickupFields() {
    List<Map<String, String>> pickupListOption = 
      List.generate(widget.pickupList?.length ?? 0, (index) => {
        'value': widget.pickupList![index]['id'].toString(),
        'text': '${widget.pickupList![index]['name'].toString()}${widget.pickupList![index]['address'].toString()}'
      });

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            T.exchangeProductFormPickupRemark,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14
            )
          ),
        ),
        Container(
          width: double.infinity,
          child: MyTextInput(
            // label: '換領人姓名',
            label: T.exchangeProductFormCardNameFieldLabel,
            labelIcon: Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Image.asset(
                icon['card_name']!,
                width: 20,
              ),
            ),
            labelColor: kPrimaryColor,
            primaryColor: getColorFromHex("#dedede"),
            secondaryColor: kSecondaryColor,
            type: TextInputType.text,
            // initialValue: userProfile.birthday,
            focused: focusField == 'card_name',
            inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            onFocusCallback: (hasFocus) {},
            onValidateCallback: (String? value) {
              // print('[ExchangeForm] cardName field onValidate');
              if(value == null || value.isEmpty){ 
                addError("CARD_NAME_ERROR");
                return '';
              }
              return null;
            },
            onChangeCallback: (String? value){
              // print('[ExchangeForm] cardName field onChange');
              if(!submited) return;
              if(value != null && value.isNotEmpty) removeError("CARD_NAME_ERROR");
              else addError("CARD_NAME_ERROR");
            },
            onSavedCallback: (newValue){
              // print('[ExchangeForm] cardName field onSaved');
              _cardName = newValue!;
            },
          ),
        ),
        buildFieldError('CARD_NAME_ERROR'),
        Container(
          width: double.infinity,
          child: MyTextInput(
            // label: '身份證前3位數字',
            label: T.exchangeProductFormCardNumFieldLabel,
            labelIcon: Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Image.asset(
                icon['card_num']!,
                width: 20,
              ),
            ),
            labelColor: kPrimaryColor,
            primaryColor: getColorFromHex("#dedede"),
            secondaryColor: kSecondaryColor,
            type: TextInputType.number,
            focused: focusField == 'card_num',
            inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            onFocusCallback: (hasFocus) {},
            onValidateCallback: (String? value) {
              // print('[ExchangeForm] cardNum field onValidate');
              if(value == null || value.isEmpty){ 
                addError("CARD_NUM_ERROR");
                return '';
              }
              return null;
            },
            onChangeCallback: (String? value){
              // print('[ExchangeForm] cardNum field onChange');
              if(!submited) return;
              if(value != null && value.isNotEmpty) removeError("CARD_NUM_ERROR");
              else addError("CARD_NUM_ERROR");
            },
            onSavedCallback: (newValue){
              // print('[ExchangeForm] cardNum field onSaved');
              _cardNum = newValue!;
            },
          ),
        ),
        buildFieldError('CARD_NUM_ERROR'),
        Container(
          width: double.infinity,
          child: OptionSelectInput(
            //--------Required--------
            // label: '換領中心',
            label: T.exchangeProductFormPickupCentreFieldLabel,
            labelIcon: Padding(
              padding: EdgeInsets.only(left: 17, right: 13),
              child: Image.asset(
                icon['shop']!,
                width: 15,
              ),
            ),
            style: TextStyle(
              color: kSecondaryColor, 
              fontSize: 16
            ),
            options: pickupListOption,
            labelColor: kPrimaryColor,
            primaryColor: getColorFromHex("#dedede"),
            indicatorColor: Colors.grey,
            secondaryColor: kSecondaryColor,
            focused: focusField == 'pickupCentre',
            inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            pickerItemHeight: 75,
            pickerItemFontSize: 14,
            onChangeCallback: (value){
              updatePickupCentre(int.parse(value));
              if(!submited) return;
              if(value != null && value.isNotEmpty) removeError("PICKUP_CENTRE_ERROR");
            },
            onSavedCallback: (newValue){
              // print('[ExchangeForm] pickupCentre field onSaved $newValue');
              _pickupCentre = newValue!;
            },
            onValidateCallback: (value){
              // print('[ExchangeForm] pickupCentre field onValidate');
              if(value == null || value.isEmpty) {
                addError("PICKUP_CENTRE_ERROR");
                return '';
              }
              return null;
            },
            onFocusCallback: (hasFocus) {},
          )
        ),
        buildFieldError('PICKUP_CENTRE_ERROR'),
        if(_tempPickupCentre != null)
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 10),
          child: Html(
            data: _tempPickupCentre!['remark'],
            style: {
              "body": Style(
                margin: EdgeInsets.zero,
                fontSize: FontSize(14)
              ),
            }
          )
        ),
        SizedBox(height: 40)
      ],
    );
  }

  Column buildExchangeQuanityField() {
    List<Map<String, String>> quanityOptions = List.generate(20, (index) => {
      'value': (index + 1).toString(),
      'text': (index + 1).toString()
    });
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          // label: '兌換數量',
          label: T.exchangeProductFormQuanityFieldLabel,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          options: quanityOptions,
          initialValue: _quanity.toString(),
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          indicatorColor: Colors.grey,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'quanity',
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onChangeCallback: (value){
            setState(() {
              _quanity = int.parse(value);
            });
            _totalPoint = _quanity * _point;
            totalPointFieldController.text = _totalPoint.toString();
          },
          onSavedCallback: (newValue){},
          onValidateCallback: (value){},
          onFocusCallback: (hasFocus) {},
        ),
        // buildFieldError('QUANITY_ERROR'),
      ],
    );
  }

  Column buildProductNameField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextInput(
                enable: false,
                // label: '禮品名稱',
                label: T.exchangeProductFormProductNameFieldLabel,
                labelColor: kPrimaryColor,
                primaryColor: getColorFromHex("#dedede"),
                secondaryColor: kPrimaryColor,
                type: TextInputType.text,
                initialValue: _name,
                focused: focusField == 'name',
                inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                onFocusCallback: (hasFocus) {
                  if(hasFocus){
                    setState(() {
                      focusField = 'name';
                    });
                  }
                },
                onValidateCallback: (String? value) {},
                onChangeCallback: (String? value){},
                onSavedCallback: (newValue){},
              ),
            ),
          ],
        ),
        // buildFieldError('CODE_ERROR'),
      ],
    );
  }

  Column buildPointField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextInput(
                enable: false,
                // label: '所需積分',
                label: T.exchangeProductFormProductPointFieldLabel,
                labelColor: kPrimaryColor,
                primaryColor: getColorFromHex("#dedede"),
                secondaryColor: kPrimaryColor,
                type: TextInputType.text,
                initialValue: _point.toString(),
                focused: focusField == 'productPoint',
                inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                onFocusCallback: (hasFocus) {
                  if(hasFocus){
                    setState(() {
                      focusField = 'productPoint';
                    });
                  }
                },
                onValidateCallback: (String? value) {},
                onChangeCallback: (String? value){},
                onSavedCallback: (newValue){},
              ),
            ),
          ],
        ),
        // buildFieldError('CODE_ERROR'),
      ],
    );
  }

  Column buildTotalPointField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextInput(
                enable: false,
                // label: '合共積分',
                label: T.exchangeProductFormTotalPointFieldLabel,
                labelColor: kPrimaryColor,
                primaryColor: getColorFromHex("#dedede"),
                secondaryColor: kPrimaryColor,
                controller: totalPointFieldController,
                type: TextInputType.text,
                focused: focusField == 'totalPoint',
                inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                onFocusCallback: (hasFocus) {
                  if(hasFocus){
                    setState(() {
                      focusField = 'totalPoint';
                    });
                  }
                },
                onValidateCallback: (String? value) {},
                onChangeCallback: (String? value){},
                onSavedCallback: (newValue){},
              ),
            ),
          ],
        ),
        // buildFieldError('CODE_ERROR'),
      ],
    );
  }

  Row buildFieldError(errorType) {
    return Row(
      children: [
        if(errors.contains(errorType))
        Expanded(
          child: Text(
            errorMap[errorType]!,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14
            )
          ),
        ),
      ],
    );
  }
}