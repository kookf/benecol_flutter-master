
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/store/store_search/store_search_screen.dart';
import 'package:benecol_flutter/screens/store/widgets/find_nearest_store_btn.dart';
import 'package:benecol_flutter/screens/store/widgets/store_body_divider.dart';
import 'package:benecol_flutter/screens/store/widgets/store_search_btn.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/option_select_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/store_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StoreBody extends StatefulWidget {
  StoreBody({ Key? key }) : super(key: key);

  @override
  _StoreBodyState createState() => _StoreBodyState();
}

class _StoreBodyState extends State<StoreBody> {
  String? _selectedArea;
  String? _selectedDistrict;
  String? _selectedStore;
  late AppLocalizations T;
  GlobalKey _formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState<String>> _districtFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      bool isLoadedAreaData = context.read<StoreProvider>().isLoadedAreaData;
      bool isLoadedDistrictData = context.read<StoreProvider>().isLoadedDistrictData;
      bool isLoadedStoreData = context.read<StoreProvider>().isLoadedStoreData;
      if(!isLoadedAreaData) getArea();
      if(!isLoadedDistrictData) getDistrict();
      if(!isLoadedStoreData) getStore();
      locationPermissionCheck();
    });
  }

  Future<void> locationPermissionCheck() async {
    var locationPermissionStatus = await Permission.location.status;
    locationPermissionStatus = await Permission.location.request();
  }

  void getArea(){
    int langId = getCurrentLangId(context);
    context.read<StoreProvider>().loadArea(langId);
  }

  void getDistrict(){
    int langId = getCurrentLangId(context);
    context.read<StoreProvider>().loadDistrict(langId);
  }

  void getStore(){
    int langId = getCurrentLangId(context);
    context.read<StoreProvider>().loadStores(langId);
  }

  void resetDistrictField(){
    if(_districtFieldKey.currentState == null) return;
    _districtFieldKey.currentState!.reset();
    setState(() {
      _selectedDistrict = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15  
      ),
      child: Column(
        children: [
          FindNearestStoreBtn(),
          StoreBodyDivider(),
          buildAreaField(),
          buildDistrictField(),
          buildStoreField(),
          StoreSearchBtn(
            onSearchBtnClick: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreSearchScreen(
                  isNearby: false,
                  area: _selectedArea,
                  district: _selectedDistrict,
                  store: _selectedStore
                ),
              ),
            );
            },
          )
        ],
      ),
    );
  }

  Container buildAreaField() {
    List<Map<String, String>>? areas = context.watch<StoreProvider>().areaData;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10
      ),
      padding: EdgeInsets.only(
        left: 15
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: kPrimaryColor
        )
      ),
      child: OptionSelectInput(
        //--------Required--------
        // label: '區域',
        label: T.storeBodyAreaFieldLabel,
        style: TextStyle(
          color: kSecondaryColor, 
          fontSize: 16
        ),
        options: areas ?? [],
        // placeholder: '選擇區域',
        placeholder: T.storeBodyAreaFieldPlaceholder,
        labelColor: kPrimaryColor,
        placeholderColor: getColorFromHex('#AAAAAA'),
        primaryColor: Colors.transparent,
        indicatorColor: Colors.grey,
        secondaryColor: kSecondaryColor,
        focused: false,
        // initialValue: _foodType?[0]['value'] ?? '',
        inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        onChangeCallback: (newValue){
          setState(() {
            _selectedArea = newValue;
          });
          resetDistrictField();
        },
        onSavedCallback: (newValue){},
        onValidateCallback: (value){},
        onFocusCallback: (hasFocus) {},
      ),
    );
  }

  Container buildDistrictField() {
    List<Map<String, String>>? districts = context.watch<StoreProvider>().districtData; 
    List<Map<String, String>> filteredDistricts;
    if(_selectedArea != null) {
      filteredDistricts = districts?.where(
        (district) => district['id'] == _selectedArea
      ).toList() ?? [];
    }else{
      filteredDistricts = districts ?? [];
    }
    List<Map<String, String>> districtOptions = filteredDistricts.map(
      (district) => {
        "value": district['value'] ?? '',
        "text": district['text'] ?? ''
      }
    ).toList();

    // print('districtOptions ${districtOptions}');

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10
      ),
      padding: EdgeInsets.only(
        left: 15
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: kPrimaryColor
        )
      ),
      child: OptionSelectInput(
        CustomKey: _districtFieldKey,
        // label: '地區',
        label: T.storeBodyDistrictFieldLabel,
        style: TextStyle(
          color: kSecondaryColor, 
          fontSize: 16
        ),
        options: districtOptions,
        // placeholder: '選擇地區',
        placeholder: T.storeBodyDistrictFieldPlaceholder,
        labelColor: kPrimaryColor,
        placeholderColor: getColorFromHex('#AAAAAA'),
        primaryColor: Colors.transparent,
        indicatorColor: Colors.grey,
        secondaryColor: kSecondaryColor,
        focused: false,
        // initialValue: _foodType?[0]['value'] ?? '',
        inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        onChangeCallback: (newValue){
          setState(() {
            _selectedDistrict = newValue;
          });
        },
        onSavedCallback: (newValue){},
        onValidateCallback: (value){},
        onFocusCallback: (hasFocus) {},
      ),
    );
  }

  Container buildStoreField() {
    List<Map<String, String>>? stores = context.watch<StoreProvider>().storeData;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10
      ),
      padding: EdgeInsets.only(
        left: 15
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: kPrimaryColor
        )
      ),
      child: OptionSelectInput(
        //--------Required--------
        // label: '店鋪',
        label: T.storeBodyStoreFieldLabel,
        style: TextStyle(
          color: kSecondaryColor, 
          fontSize: 16
        ),
        options: stores ?? [],
        // placeholder: '選擇店鋪',
        placeholder: T.storeBodyStoreFieldPlaceholder,
        labelColor: kPrimaryColor,
        placeholderColor: getColorFromHex('#AAAAAA'),
        primaryColor: Colors.transparent,
        indicatorColor: Colors.grey,
        secondaryColor: kSecondaryColor,
        focused: false,
        // initialValue: _foodType?[0]['value'] ?? '',
        inputPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        onChangeCallback: (newValue){
          setState(() {
            _selectedStore = newValue;
          });
        },
        onSavedCallback: (newValue){},
        onValidateCallback: (value){},
        onFocusCallback: (hasFocus) {},
      ),
    );
  }
}
