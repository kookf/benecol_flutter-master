
import 'dart:convert';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/models/food.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_data.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_grid_header.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_grid_row.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_grid_sub_header.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_header.dart';
import 'package:benecol_flutter/screens/calculator/widgets/calculator_record_card.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorBody extends StatefulWidget {
  CalculatorBody({ Key? key }) : super(key: key);

  @override
  _CalculatorBodyState createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  List<Map<String, String>>? _foodType;
  List<Food>? _foods;
  String? _selectedFoodTypeValue;
  String? _selectedFoodTypeStr;
  double amount = 0;
  LocalStorageSingleton localStorageSingleton = LocalStorageSingleton();
  List<dynamic> _records = [];
  String _activeTap = 'calculator';
  late AppLocalizations T;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      initFood();
      initFoodType();
      getRecordList();
      await localStorageSingleton.setValue('calculatorRecords', '');
    });
  }

  void initFoodType(){
    String langCode = getCurrentLangCode(context);
    setState(() {
      _foodType = getFoodTypes(langCode);
      _selectedFoodTypeValue = _foodType?[0]['value'] ?? null;
      _selectedFoodTypeStr = _foodType?[0]['text'] ?? null;
    });
  }

  void initFood(){
    String langCode = getCurrentLangCode(context);
    setState(() {
      _foods = getFoods(langCode);
    });
  }

  void addFoodQty(int index){
    if(_foods == null) return;
    if((_foods![index].accQty / _foods![index].qty) < 10){
      setState(() {
        _foods![index].accQty += _foods![index].qty;
      });
      if(!!_foods![index].isChecked){
        setState(() {
          amount += _foods![index].chol;
        });
      }
    }
  }

  void minusFoodQty(int index){
    if(_foods == null) return;
    if((_foods![index].accQty > _foods![index].qty)){
      setState(() {
        _foods![index].accQty -= _foods![index].qty;
      });
      if(!!_foods![index].isChecked){
        setState(() {
          amount -= _foods![index].chol;
        });
      }
    }
  }

  void selectFood(int index){
    if(_foods == null) return;
    setState(() {
      _foods![index].isChecked = !_foods![index].isChecked;
    });

    double _n = _foods![index].accQty / _foods![index].qty;
    double _amount = (_n * _foods![index].chol);

    if(!!_foods![index].isChecked){
      setState(() {
        amount += _amount;
      });
    }else{
      setState(() {
        amount -= _amount;
      });
    }
  }

  onFoodTypeChange(value){
    setState(() {
      _selectedFoodTypeValue = value;
    });
  }

  onClearFoods(){
    if(_foods == null) return;
    for(int i = 0; i < _foods!.length; i++){
      setState(() {
        _foods![i].isChecked = false;
        _foods![i].accQty = _foods![i].qty;
        amount = 0;
      });
    }
  }

  getRecordList() async {
    String? _recordListStr = await localStorageSingleton.getValue('calculatorRecords');
    if(_recordListStr == null) return;
    try{
      setState(() {
        _records = json.decode(_recordListStr);
      });
    }catch (e){

    }
  }

  deleteRecordCallback(int index) async{
    setState(() {
      _records.removeAt(index);
    });
    saveRecords();
  }

  onSaveRecord() async {
    if(amount == 0 || _foods == null) return;
    Map<String, dynamic> _record = {};
    _record['amount'] = amount;
    _record['date'] = DateTime.now().toString();
    _record['foods'] = [];
    for(int i = 0; i < _foods!.length; i++){
      if(_foods![i].isChecked == true){
        Map<String, dynamic> _foodJson = _foods![i].toJson();
        _foodJson['amount'] = (_foods![i].accQty/_foods![i].qty)*_foods![i].chol;
        _record['foods'].add(_foodJson);
      }
    }
    setState(() {
      _records.add(_record);
    });
    saveRecords();
    showAlertDialogWithOnlyConfirm(
      context, 
      // content:'儲存成功！', 
      content:T.calculatorSaveSuccessfully, 
      // actionText: '確定'
      actionText: T.dialogConfirm
    );
    onClearFoods();
  }

  saveRecords() async {
    await localStorageSingleton.setValue('calculatorRecords', json.encode(_records));
  }

  onTapClick(String tapName){
    setState(() {
      _activeTap = tapName;
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;

    return Column(
      children:[ 
        CalculatorHeader(
          onTapClick: onTapClick,
          activeTap: _activeTap
        ),
        Expanded(
          child: SingleChildScrollView(
            child: (_activeTap == 'calculator')
            ? buildCalculatorSection()
            : buildRecordSection(),
          ),
        ),
        if(_activeTap == 'calculator')
        Container(
          width: double.infinity,
          height: 75,
          padding: EdgeInsets.only(
            top: 7,
            left: 10,
            right: 10,
            bottom: 7
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: getColorFromHex('#d9d9d9')
              )
            ),
            color: getColorFromHex('#f8f7f8')
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // '總攝取量',
                    T.calculatorTotalIntake,
                    style: TextStyle(
                      color: (amount.round() < 501)
                      ? kPrimaryColor
                      : getColorFromHex('#e21a3f'),
                      fontSize: 18
                    )
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        // '${amount.round()}毫克',
                        '${amount.round()}${T.calculatorMg}',
                        style: TextStyle(
                          color: (amount.round() < 501)
                          ? kPrimaryColor
                          : getColorFromHex('#e21a3f'),
                          fontSize: 25,
                          height: 1.2
                        )
                      ),
                      SizedBox(width: 5),
                      if(amount.round() > 0)
                      GestureDetector(
                        onTap: onClearFoods,
                        child: Text(
                          // 'X 清除',
                          'X ${T.calculatorClear}',
                          style: TextStyle(
                            height: 1.7
                          )
                        ),
                      )
                    ],
                  )
                ],
              ),
              TextButton(
                onPressed: onSaveRecord, 
                child: Text(
                  // '儲存紀錄',
                  T.calculatorSaveRecord,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  )
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: (amount.round() == 0) ? kSecondaryColor.withOpacity(0.4) : kSecondaryColor,
                  padding: EdgeInsets.symmetric(
                    vertical:4,
                    horizontal: 4
                  ),
                  minimumSize: Size.zero
                ),
              )
            ],
          ),
        )
      ]
    );
  }

  Padding buildRecordSection() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15
      ),
      child: Column(
        children: [
          if(_records.length > 0)
          ...(List.generate(_records.length, (index) => 
            CalculatorRecordCard(
              index: index,
              record: _records[index],
              deleteCallback: deleteRecordCallback
            )
          ).reversed.toList()),
          if(_records.length == 0)
          Text(
            // '未有記錄。'
            T.calculatorNoRecord
          )
        ]
      ),
    );
  }

  Column buildCalculatorSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: 10
          ),
          width: double.infinity,
          child: Text(
            // '每日攝取的食物膽固醇*含量:',
            T.calculatorHeaderTxt,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w300
            ),
          )
        ),
        if(_selectedFoodTypeValue != null)
        buildFoodTypeSelect(),
        CalculatorGridHeader(),
        CalculatorGridSubHeader(selectedFoodTypeStr: _selectedFoodTypeStr),
        if(_foods != null)
        ...List.generate(_foods!.length, 
          (index) => 
          (_foods![index].typeId.toString() == _selectedFoodTypeValue) 
          ? CalculatorGridRow(
            food: _foods![index],
            onAddClick:(){
              addFoodQty(index);
            },
            onMinusClick:(){
              minusFoodQty(index);
            },
            onSelectClick:(){
              selectFood(index);
            }
          )
          : SizedBox()
        ).toList(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  // '*根據美國心臟協會建議，健康成年人及兒童每日的膽固醇攝取量不應多於300毫克，膽固醇超標人士及心臟病患者，每日最多攝取200毫克膽固醇。',
                  T.calculatorRemark1,
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  // '資料來源：香港中文大學網上藥物咨詢平台',
                  T.calculatorRemark2,
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  // '以上食物膽固醇只供參考，倍樂醇及Raisio Plc將不會為任何人對本應用程式的任何內容的應用，負上醫療或法律責任。',
                  T.calculatorRemark3,
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Padding buildFoodTypeSelect() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15
      ),
      child: OptionSelectInput(
        //--------Required--------
        // label: '種類',
        label: T.calculatorFoodTypeTxt,
        style: TextStyle(
          color: kSecondaryColor, 
          fontSize: 16
        ),
        options: _foodType ?? [],
        placeholder: '',
        labelColor: kPrimaryColor,
        placeholderColor: kSecondaryColor,
        primaryColor: getColorFromHex("#dedede"),
        indicatorColor: Colors.grey,
        secondaryColor: kSecondaryColor,
        focused: false,
        initialValue: _foodType?[0]['value'] ?? '',
        inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        onChangeCallback: onFoodTypeChange,
        onSavedCallback: (newValue){},
        onValidateCallback: (value){},
        onFocusCallback: (hasFocus) {},
      ),
    );
  }
}
