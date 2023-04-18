import 'dart:io';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/store_provider.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/apply_points_form_controller.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/code_sample.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/invoice_sample.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/upload_sample.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/date_time_select_input.dart';
import 'package:benecol_flutter/widgets/my_text_input.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../widgets/my_text_number_input.dart';

class ApplyPointsForm extends StatefulWidget {
  ApplyPointsFormController controller;

  ApplyPointsForm({ 
    Key? key,
    required this.controller
  }) : super(key: key);

  @override
  _ApplyPointsFormState createState() => _ApplyPointsFormState(controller);
}

class _ApplyPointsFormState extends State<ApplyPointsForm> {
  bool submited = false;
  String focusField = '';
  late AppLocalizations T;
  List<String> errors = [];
  late Map<String, String> errorMap;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime minimumBoughtDay = DateTime.now().subtract(Duration(days: 180));

  var icon = {
  	"date":"assets/icons/icon-2.png",
  	"quanity":"assets/icons/icon-product.png",
  	"store":"assets/icons/icon-4.png",
  	"code":"assets/icons/icon-5.png",
  	"show":"assets/icons/icon-6.png"
  };

  String code = '';
  String birthdate = '';
  String quanity = '';
  String store = '';

  File? invoiceImage1;
  File? invoiceImage2;
  File? invoiceImage3;

  String? imagePath1;
  String? imagePath2;
  String? imagePath3;

  List invoiceImagePathList = [];
  bool isShowCodeSampleBlock = false;
  bool isShowUploadSampleBlock = false;

  _ApplyPointsFormState(ApplyPointsFormController _controller) {
    _controller.submit = submit;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      // autoShowSampleModal();
      autoShowCodeSampleBlock();
      autoShowUploadSampleBlock();
    });
  }

  autoShowCodeSampleBlock() async {
    LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
    String? _isNoAutoCodeSample =  await _localStorageSingleton.getValue('noAutoCodeSample');
    if(_isNoAutoCodeSample == null){
      setState(() {
        isShowCodeSampleBlock = true;
      });
    }
  }

  autoShowUploadSampleBlock() async {
    LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
    String? _isNoAutoUploadSample =  await _localStorageSingleton.getValue('noAutoUploadSample');
    if(_isNoAutoUploadSample == null){
      setState(() {
        isShowUploadSampleBlock = true;
      });
    }
  }

  // autoShowSampleModal() async {
  //   LocalStorageSingleton _localStorageSingleton = LocalStorageSingleton();
  //   String? _isNoAutoInvoiceSample =  await _localStorageSingleton.getValue('noAutoInvoiceSample');
  //     // print('this is _isNoAutoInvoiceSample $_isNoAutoInvoiceSample');
  //   if(_isNoAutoInvoiceSample == null){
  //     Future.delayed(Duration(seconds: 1), () { 
  //       showSampleModal(context, true);
  //     });
  //   }
  // }

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

  bool validateInvoiceField(){
    if(invoiceImagePathList == null || invoiceImage1 == null){
      addError("INVOICE_ERROR");
      return false;
    }
    removeError("INVOICE_ERROR");
    return true;
  }

  void submit(BuildContext context) async {

    // invoiceImagePathList.insert(0,imagePath1);
    // invoiceImagePathList.insert(1,imagePath1);
    // invoiceImagePathList.insert(2,imagePath1);

    invoiceImagePathList = [imagePath1,imagePath2,imagePath3];
    invoiceImagePathList.removeWhere((element) => element==null);

    print('form submit imageList = ${invoiceImagePathList}');
    setState(() {
      submited = true;
    });
    if(_formKey.currentState!.validate()){
      bool isInvoiceFieldValid = validateInvoiceField();
      // print('[ApplyPointsForm] submit isInvoiceFieldValid $isInvoiceFieldValid');
      if(!isInvoiceFieldValid) return;

      _formKey.currentState!.save();

      Map<String, dynamic> _params = {
        "code": code,
        "date": birthdate,
        "quanity": quanity,
        "store": store,
      };

      // String _invoicePath = invoiceImagePath;

      var result = await context.read<UserProvider>().applyPoints(context, _params, invoiceImagePathList);
      // print('[ApplyPointsForm] submit result: $result');
      bool isSuccess = result['success'];
      String message = '';
      if(isSuccess){
        // message = '謝謝！已收到您登記積分的指示，合資格的積分會於審托後1個工作天內存入戶口，詳情可於“積分記錄”查閱。';
        message = T.applyPointFormSuccessMessage;
      }else{
        switch(result['errorType']){
          case ('OVER_180DAY_ERROR'):
            // message = '非常抱歉！閣下須於購買日期計起180日內登記積分。';
            message = T.applyPointFormFailOver180Message;
            break;
          case ('DEFAULT_ERROR'):
          default:
            // message = '申請失敗';
            message = T.applyPointFormFailDefaultMessage;
        }
      }
      // showNoIconMessageDialog(message);
      await showAlertDialogWithOnlyConfirm(
        context,
        content: message,
        actionText: T.dialogConfirm
      );
      Navigator.pop(context);
    }else{
      showNoIconMessageDialog(T.applyPointFormFailDefaultMessage);
    }
  }

  void showInvoiceSampleModal(BuildContext context, bool auto){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return InvoiceSample(
            isShowCheckbox: auto ? true : false
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void showCodeSampleModal(BuildContext context){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return CodeSample();
        },
        fullscreenDialog: true,
      ),
    );
  }

  void showUploadSampleModal(BuildContext context){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return UploadSample();
        },
        fullscreenDialog: true,
      ),
    );
  }

  // void resetInvoiceImage(){
  //   setState(() {
  //     invoiceImage1 = null;
  //     // invoiceImagePath = null;
  //     invoiceImagePathList.clear();
  //   });
  // }

  void resetFormFocus(){
    setState(() {
      focusField = '';
    });
    FocusScope.of(context).unfocus();
  }

  void onInvoiceBtnClickImage1() async{
    resetFormFocus();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              // '拍照',
              T.applyPointFormInvoiceTakePhotoTxt,
              style: TextStyle(
                color: kPrimaryColor
              )
            ),
            onPressed: () async {
              Navigator.pop(context);
              imagePickHandle('camera','1');
            }
          ),
          CupertinoActionSheetAction(
            child: Text(
              // '選擇圖片',
              T.applyPointFormInvoicePhotoLibraryTxt,
              style: TextStyle(
                color: kPrimaryColor
              )
            ),
            onPressed: () async{
              Navigator.pop(context);
              imagePickHandle('gallery','1');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            // '取消',
            T.applyPointFormInvoiceCancelTxt,
            style: TextStyle(
              color: Colors.red
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
    return;
  }
  void onInvoiceBtnClickImage2() async{
    resetFormFocus();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              // '拍照',
              T.applyPointFormInvoiceTakePhotoTxt,
              style: TextStyle(
                color: kPrimaryColor
              )
            ),
            onPressed: () async {
              Navigator.pop(context);
              imagePickHandle('camera','2');
            }
          ),
          CupertinoActionSheetAction(
            child: Text(
              // '選擇圖片',
              T.applyPointFormInvoicePhotoLibraryTxt,
              style: TextStyle(
                color: kPrimaryColor
              )
            ),
            onPressed: () async{
              Navigator.pop(context);
              imagePickHandle('gallery','2');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            // '取消',
            T.applyPointFormInvoiceCancelTxt,
            style: TextStyle(
              color: Colors.red
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
    return;
  }
  void onInvoiceBtnClickImage3() async{
    resetFormFocus();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              // '拍照',
              T.applyPointFormInvoiceTakePhotoTxt,
              style: TextStyle(
                color: kPrimaryColor
              )
            ),
            onPressed: () async {
              Navigator.pop(context);
              imagePickHandle('camera','3');
            }
          ),
          CupertinoActionSheetAction(
            child: Text(
              // '選擇圖片',
              T.applyPointFormInvoicePhotoLibraryTxt,
              style: TextStyle(
                color: kPrimaryColor
              )
            ),
            onPressed: () async{
              Navigator.pop(context);
              imagePickHandle('gallery','3');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            // '取消',
            T.applyPointFormInvoiceCancelTxt,
            style: TextStyle(
              color: Colors.red
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
    return;
  }

  void imagePickHandle(String type,String handleType) async{
    try{
      ImageSource source;
      switch(type){
        case 'camera':
          source = ImageSource.camera;
          break;
        case 'gallery':
        default:
          source = ImageSource.gallery;
      }
      final ImagePicker _picker = ImagePicker();
      XFile? _image = await _picker.pickImage(source: source);
      if(_image == null) {
        // resetInvoiceImage();
        return;
      }

      final imageTemp = File(_image.path);
      final imagePath = _image.path;

      setState(() {
        if(handleType == '1'){
          invoiceImage1 = imageTemp;
          imagePath1 = imagePath;
        }else if(handleType == '2'){
          invoiceImage2 = imageTemp;
          imagePath2 = imagePath;
        }else{
          invoiceImage3 = imageTemp;
          imagePath3 = imagePath;
        }
        // invoiceImagePath = imagePath;
        // invoiceImagePathList.add(list);
        // invoiceImagePathList.removeWhere((element) => element=='');
      });
    }on PlatformException catch (e){
      // resetInvoiceImage();
    }
    if(submited){
      validateInvoiceField();
    }
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    errorMap = {
      // "BOUGHTDATE_ERROR": '請選擇日期',
      "BOUGHTDATE_ERROR": T.applyPointFormBoughtDateError,
      // "QUANITY_ERROR": '請輸入數量',
      "QUANITY_ERROR": T.applyPointFormQuanityError,
      // "STORE_ERROR": '請選擇店鋪',
      "STORE_ERROR": T.applyPointFormStoreError,
      // "CODE_ERROR": '請輸入收據號碼',
      "CODE_ERROR": T.applyPointFormCodeError,
      // "INVOICE_ERROR": '請上傳收據'
      "INVOICE_ERROR": T.applyPointFormInvoiceError
    };

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10
        ),
        child: Column(
          children: [
            buildBoughtDateField(),
            buildQuanityField(),
            buildStoreField(),
            buildCodeField(),
            GestureDetector(
              onTap: (){
                showInvoiceSampleModal(context, false);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: getColorFromHex("#dedede")
                    )
                  )
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 10,
                        top: 10,
                        bottom: 10
                      ),
                      child: Image.asset(
                        icon['show']!,
                        width: 20,
                      ),
                    ),
                    Text(
                      // '收據樣板',
                      T.applyPointFormInvoiceSampleLabel,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 17
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextButton(
                      //         onPressed: onInvoiceBtnClick,
                      //         child: Text(
                      //           // '上傳收據',
                      //           T.applyPointFormInvoiceTitle,
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w400,
                      //             color: kPrimaryColor
                      //           )
                      //         ),
                      //         style: ButtonStyle(
                      //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.all(
                      //                 Radius.circular(5)
                      //               ),
                      //               side: BorderSide(color: kPrimaryColor)
                      //             )
                      //           )
                      //         )
                      //       ),
                      //     )
                      //   ]
                      // ),
                      Row(
                        children: [
                          GestureDetector(
                           onTap: (){
                             onInvoiceBtnClickImage1();
                           },
                           child:  DottedBorder(
                               color: Colors.grey,
                               // padding: EdgeInsets.only(left: 35),
                               radius:  Radius.circular(50),
                               strokeWidth: 0.5,
                               child: Container(
                                 color: Colors.grey[200],
                                 width: 80,
                                 height: 80,
                                 child:  invoiceImage1 != null?Container(
                                   padding: EdgeInsets.all(5),
                                   child: Image.file(invoiceImage1!),
                                 ):Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Icon(Icons.add,size: 50,color: Colors.grey,),
                                     Text('${T.upload}')
                                   ],
                                 ),
                               )
                           ),
                         ),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              onInvoiceBtnClickImage2();
                            },
                            child:  DottedBorder(
                                color: Colors.grey,
                                // padding: EdgeInsets.only(left: 35),
                                radius:  Radius.circular(50),
                                strokeWidth: 0.5,
                                child: Container(
                                  color: Colors.grey[200],
                                  width: 80,
                                  height: 80,
                                  child:  invoiceImage2 != null?Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.file(invoiceImage2!),
                                  ):Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,size: 50,color: Colors.grey,),
                                      Text('${T.upload}')
                                    ],
                                  ),
                                )
                            ),
                          ),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              onInvoiceBtnClickImage3();
                            },
                            child:  DottedBorder(
                                color: Colors.grey,
                                // padding: EdgeInsets.only(left: 35),
                                radius:  Radius.circular(50),
                                strokeWidth: 0.5,
                                child: Container(
                                  color: Colors.grey[200],
                                  width: 80,
                                  height: 80,
                                  child:  invoiceImage3 != null?Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.file(invoiceImage3!),
                                  ):Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,size: 50,color: Colors.grey,),
                                      Text('${T.upload}')
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),

                      buildFieldError('INVOICE_ERROR'),
                      Text(
                        // '每次請上傳一張清晰的收據圖片，上傳圖片格式：jpg(圖片不可超過3MB)',
                        T.applyPointFormInvoiceRemark,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                        )
                      ),
                      // invoiceImage != null ? buildInvoiceImage(invoiceImage!) : SizedBox()
                    ],
                  ),
                  if(isShowUploadSampleBlock)
                  GestureDetector(
                    onTap: (){
                      // print('click');
                      setState(() {
                        isShowUploadSampleBlock = false;
                      });
                      showUploadSampleModal(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.transparent
                      ),
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

  // Padding buildInvoiceImage(File invoiceImage) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(15.0),
  //       child: Image.file(invoiceImage)
  //     ),
  //   );
  // }

  Column buildBoughtDateField(){
    return Column(
      children: [
        DateTimeSelectInput(
          //--------Required--------
          // label: '購買日期',
          label: T.applyPointFormBoughtDateFieldLabel,
          labelIcon: Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Image.asset(
              icon['date']!,
              width: 20,
            ),
          ),
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          initialValue: '',
          // minimumDate: DateTime(2017,6,20),
          minimumDate: minimumBoughtDay,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          secondaryColor: kSecondaryColor,
          focused: focusField == 'boughtDate',
          // placeholder: 'YYYY-MM-DD',
          onChangeCallback: (value){
            if(!submited) return;
            try{
              DateTime.parse(value);
              removeError("BOUGHTDATE_ERROR");
            }catch(e){
            }
          },
          onSavedCallback: (newValue){
            birthdate = newValue!;
          },
          onValidateCallback: (value){
            try{
              DateTime.parse(value!);
            }catch(e){
              addError("BOUGHTDATE_ERROR");
            }
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'boughtDate';
              });
            }
          },
        ),
        buildFieldError('BOUGHTDATE_ERROR'),
      ],
    );
  }

  Column buildQuanityField(){
    List<Map<String, String>> quanityOptions = List.generate(20, (index) => {
      'value': (index + 1).toString(),
      'text': (index + 1).toString()
    });
    return Column(
      children: [
        OptionSelectInput(
          //--------Required--------
          // label: '購買數量（盒）',
          label: T.applyPointFormQuanityFieldLabel,
          labelIcon: Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Image.asset(
              icon['quanity']!,
              width: 20,
            ),
          ),
          // remark: "*6支裝為一盒，登記數量必須以盒數為單位。",
          remark: T.applyPointFormQuanityFieldRemark,
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          options: quanityOptions,
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          indicatorColor: Colors.grey,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'quanity',
          inputPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("QUANITY_ERROR");
          },
          onSavedCallback: (newValue){
            quanity = newValue!;
          },
          onValidateCallback: (value){
            if(value == null || value.isEmpty) addError("QUANITY_ERROR");
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'quanity';
              });
            }
          },
        ),
        buildFieldError('QUANITY_ERROR'),
      ],
    );
  }

  Column buildStoreField(){
    List<Map<String, String>>? storeOptions = context.watch<StoreProvider>().storeData;
    return Column(
      children: [
        // Text('hello ${context.watch<StoreProvider>().isLoadedStoreData}'),
        OptionSelectInput(
          //--------Required--------
          // label: '購買地點',
          label: T.applyPointFormStoreFieldLabel,
          labelIcon: Padding(
            padding: EdgeInsets.only(left: 17, right: 13),
            child: Image.asset(
              icon['store']!,
              width: 15,
            ),
          ),
          style: TextStyle(
            color: kSecondaryColor, 
            fontSize: 16
          ),
          options: storeOptions ?? [],
          labelColor: kPrimaryColor,
          primaryColor: getColorFromHex("#dedede"),
          indicatorColor: Colors.grey,
          secondaryColor: kSecondaryColor,
          focused: focusField == 'store',
          inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          onChangeCallback: (value){
            if(!submited) return;
            if(value != null && value.isNotEmpty) removeError("STORE_ERROR");
          },
          onSavedCallback: (newValue){
            store = newValue!;
          },
          onValidateCallback: (value){
            if(value == null || value.isEmpty) addError("STORE_ERROR");
          },
          onFocusCallback: (hasFocus) {
            if(hasFocus){
              setState(() {
                focusField = 'store';
              });
            }
          },
        ),
        buildFieldError('STORE_ERROR'),
      ],
    );
  }

  buildCodeField() {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MyTextNumberInput(
                    label: T.applyPointFormCodeFieldLabel,
                    labelIcon: Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Image.asset(
                        icon['code']!,
                        width: 20,
                      ),
                    ),
                    // suffixIcon: GestureDetector(
                    //   onTap: (){
                    //     // print('Show clicked');
                    //     showSampleModal(context, false);
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 0, right: 5),
                    //     child: Image.asset(
                    //       icon['show']!,
                    //       width: 20,
                    //     ),
                    //   ),
                    // ),
                    // remark: "*毋須輸入符號及英文",
                    remark: T.applyPointFormCodeFieldRemark,
                    labelColor: kPrimaryColor,
                    primaryColor: getColorFromHex("#dedede"),
                    secondaryColor: kSecondaryColor,
                    type: TextInputType.text,
                    focused: focusField == 'code',
                    inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    onFocusCallback: (hasFocus) {
                      if(hasFocus){
                        setState(() {
                          focusField = 'code';
                        });
                      }
                    },
                    onValidateCallback: (String? value) {
                      if(value == null || value.isEmpty) addError("CODE_ERROR");
                    },
                    onChangeCallback: (String? value){
                      if(!submited) return;
                      if(value != null && value.isNotEmpty) removeError("CODE_ERROR");
                      else addError("CODE_ERROR");
                    },
                    onSavedCallback: (newValue){
                      code = newValue!;
                    },
                  ),
                ),
              ],
            ),
            buildFieldError('CODE_ERROR'),
          ],
        ),
        if(isShowCodeSampleBlock)
        GestureDetector(
          onTap: (){
            // print('click');
            setState(() {
              isShowCodeSampleBlock = false;
            });
            showCodeSampleModal(context);
          },
          child: Container(
            width: double.infinity,
            height: 66,
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
          ),
        )
      ]
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