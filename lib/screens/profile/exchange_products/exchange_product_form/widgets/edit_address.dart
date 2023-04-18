import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/widgets/bottom_button.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditAddress extends StatefulWidget {
  VoidCallback? dismissCallback;
  int id;
  Map<String, dynamic> data;

  EditAddress({
    this.dismissCallback,
    required this.id,
    required this.data
  }):super();

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  late AppLocalizations T;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late Map<String, String> errorMap;
  String focusField = '';
  bool submited = false;

  String name = '';
  String address = '';
  String phone = '';
  int addressId = 0; // 0 = add address

  var icon = {
  	"title":"assets/icons/icon-9.png",
  	"name":"assets/icons/icon-14.png",
  	"address":"assets/icons/icon-15.png",
  	"phone":"assets/icons/icon-16.png"
  };

  @override
  void initState() {
    addressId = widget.id;
    name = widget.data['name'] ?? '';
    address = widget.data['address'] ?? '';
    phone = widget.data['phone'] ?? '';
    super.initState();
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

  Future<void> submit() async {
    // print('[EDITADDRESS] submit click ${_formKey.currentState}');
    if(_formKey.currentState==null) return;
    setState(() {
      submited = true;
    });
    //form submit
    if(!_formKey.currentState!.validate()){
      // print('[EDITADDRESS] validation not passed');
      return;
    }
    //call add / edit address api
    // print('[EDITADDRESS] validation passed');
    _formKey.currentState!.save();

    final Map<String, dynamic> sendObj = {
      'name': name,
      'address': address,
      'phone': phone,
      'id': addressId
    };
    var result = await context.read<UserProvider>().updateUserAddress(context, sendObj);

    if(result['success'] == true){
      //navigator pop and call the callback
      Navigator.pop(context);
      if(widget.dismissCallback != null){
        widget.dismissCallback!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    errorMap = {
      // "NAME_ERROR": '請輸入名稱。',
      "NAME_ERROR": T.exchangeProductEditAddressNameError,
      // "ADDRESS_ERROR": '請輸入地址。',
      "ADDRESS_ERROR": T.exchangeProductEditAddressAddressError,
      // "PHONE_ERROR": '請輸入正確電話。'
      "PHONE_ERROR": T.exchangeProductEditAddressPhoneError
    };

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '地址信息',
          T.exchangeProductEditAddressTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        // "*請在下方填寫相關資料並細心確認，一經送出將不能更改。",
                        T.exchangeProductEditAddressRemark,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14
                        )
                      ),
                      buildNameField(),
                      buildAddressField(),
                      buildPhoneField()
                    ],
                  ),
                ),
              )
            ),
          ),
          BottomButton(
            // buttonText: '確定',
            buttonText: T.exchangeProductEditAddressConfirm,
            press: submit
          )
        ],
      )
    );
  }

  Column buildNameField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextInput(
                // label: '收件人姓名',
                label: T.exchangeProductEditAddressNameFieldLabel,
                labelColor: kPrimaryColor,
                labelIcon: Padding(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: Image.asset(
                    icon['name']!,
                    width: 20,
                  ),
                ),
                primaryColor: getColorFromHex("#dedede"),
                secondaryColor: kSecondaryColor,
                type: TextInputType.text,
                initialValue: name,
                focused: focusField == 'name',
                inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                onFocusCallback: (hasFocus) {
                  if(hasFocus){
                    setState(() {
                      focusField = 'name';
                    });
                  }
                },
                onValidateCallback: (String? value) {
                  // print('[EDITADDRESS] Validating name field');
                  if(value == null || value.isEmpty) {
                    addError("NAME_ERROR");
                    return '';
                  }
                  return null;
                },
                onChangeCallback: (String? value){
                  if(!submited) return;
                  if(value != null && value.isNotEmpty) removeError("NAME_ERROR");
                  else addError("NAME_ERROR");
                },
                onSavedCallback: (newValue){
                  name = newValue!;
                },
              ),
            ),
          ],
        ),
        buildFieldError('NAME_ERROR'),
      ],
    );
  }

  Column buildAddressField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextInput(
                // label: '郵寄地址',
                label: T.exchangeProductEditAddressAddressFieldLabel,
                labelColor: kPrimaryColor,
                labelIcon: Padding(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: Image.asset(
                    icon['address']!,
                    width: 20,
                  ),
                ),
                primaryColor: getColorFromHex("#dedede"),
                secondaryColor: kSecondaryColor,
                type: TextInputType.text,
                initialValue: address,
                focused: focusField == 'address',
                inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                onFocusCallback: (hasFocus) {
                  if(hasFocus){
                    setState(() {
                      focusField = 'address';
                    });
                  }
                },
                onValidateCallback: (String? value) {
                  // print('[EDITADDRESS] Validating address field');
                  if(value == null || value.isEmpty) {
                    addError("ADDRESS_ERROR");
                    return '';
                  }
                  return null;
                },
                onChangeCallback: (String? value){
                  if(!submited) return;
                  if(value != null && value.isNotEmpty) removeError("ADDRESS_ERROR");
                  else addError("ADDRESS_ERROR");
                },
                onSavedCallback: (newValue){
                  address = newValue!;
                },
              ),
            ),
          ],
        ),
        buildFieldError('ADDRESS_ERROR'),
      ],
    );
  }

  Column buildPhoneField() {
    return Column(
      children: [
        MyTextInput(
          // label: '電話號碼',
          label: T.exchangeProductEditAddressPhoneFieldLabel,
          labelColor: kPrimaryColor,
          labelIcon: Padding(
            padding: EdgeInsets.only(left: 5, right: 10),
            child: Image.asset(
              icon['phone']!,
              width: 20,
            ),
          ),
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          type: TextInputType.number,
          focused: false,
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          initialValue: phone,
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'phone';
              });
            }
          },
          onValidateCallback: (String? value) {
            // print('[EDITADDRESS] Validating phone field');
            if(value == null || value.isEmpty || !phoneRegExp.hasMatch(value)){
              addError("PHONE_ERROR");
              return '';
            }
            return null;
          },
          onChangeCallback: (String? value){
            if(!submited) return '';
            if(value != null && value.isNotEmpty && phoneRegExp.hasMatch(value)){
              removeError("PHONE_ERROR");
              return '';
            }else{
              addError("PHONE_ERROR");
            }
          },
          onSavedCallback: (newValue){
            // print('[PHONE] onSavedCallback');
            phone = newValue!;
          },
        ),
        buildFieldError('PHONE_ERROR'),
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