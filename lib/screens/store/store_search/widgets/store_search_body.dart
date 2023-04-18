
import 'package:benecol_flutter/screens/store/store_search/widgets/store_card.dart';
import 'package:benecol_flutter/screens/store/store_search/widgets/store_search_select.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:benecol_flutter/providers/store_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StoreSearchBody extends StatefulWidget {
  bool? isNearby;
  String? area;
  String? district;
  String? store;

  StoreSearchBody({ 
    Key? key,
    this.isNearby,
    this.area,
    this.district,
    this.store
  }) : super(key: key);

  @override
  _StoreSearchBodyState createState() => _StoreSearchBodyState();
}

class _StoreSearchBodyState extends State<StoreSearchBody> {
  late AppLocalizations T;
  List<Map<String, dynamic>>? _locationData;
  List<Map<String, dynamic>>? _areaData;
  List<Map<String, dynamic>>? _districtData;
  List<Map<String, dynamic>>? _storeData;

  String? _area;
  String? _district;
  String? _store;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      bool isLoadedLocationData = context.read<StoreProvider>().isLoadedLocationData;
      if(!isLoadedLocationData) await getLocations();

      bool isLoadedAreaData = context.read<StoreProvider>().isLoadedAreaData;
      bool isLoadedDistrictData = context.read<StoreProvider>().isLoadedDistrictData;
      bool isLoadedStoreData = context.read<StoreProvider>().isLoadedStoreData;
      if(!isLoadedAreaData) await getArea();
      if(!isLoadedDistrictData) await getDistrict();
      if(!isLoadedStoreData) await getStore();
      initArea();
      initDistrict();
      initStore();

      if(widget.isNearby ?? false){
        await searchNearby();
      }else{
        updateLocationData();
      }
    });
  }

  Future<void> getArea() async {
    int langId = getCurrentLangId(context);
    await context.read<StoreProvider>().loadArea(langId);
  }

  void initArea(){
    setState(() {
      _areaData = context.read<StoreProvider>().areaData;
      _area = widget.area;
    });
  }

  Future<void> getDistrict() async {
    int langId = getCurrentLangId(context);
    await context.read<StoreProvider>().loadDistrict(langId);
    setState(() {
      _districtData = context.read<StoreProvider>().districtData;
    });
  }

  void initDistrict(){
    setState(() {
      _districtData = context.read<StoreProvider>().districtData;
      _district = widget.district;
    });
  }

  Future<void> getStore() async {
    int langId = getCurrentLangId(context);
    await context.read<StoreProvider>().loadStores(langId);
    setState(() {
      _storeData = context.read<StoreProvider>().storeData;
    });
  }

  void initStore(){
    setState(() {
      _storeData = context.read<StoreProvider>().storeData;
      _store = widget.store;
    });
  }

  void resetDistrictField(){
    // if(_districtFieldKey.currentState == null) return;
    // _districtFieldKey.currentState!.reset();
    // setState(() {
    //   _selectedDistrict = null;
    // });
  }

  void updateLocationData(){
    List<Map<String, dynamic>>? _newLocationData = context.read<StoreProvider>().locationData;

    if(_newLocationData == null) return;
    if(_area != null){
      _newLocationData = _newLocationData.where((location) => location['areaId'] == _area).toList();
    }
    if(_district != null){
      _newLocationData = _newLocationData.where((location) => location['districtId'] == _district).toList();
    }
    if(_store != null){
      _newLocationData = _newLocationData.where((location) => location['storeId'] == _store).toList();
    }

    setState(() {
      _locationData = _newLocationData;
    });
  }

  Future<void> searchNearby() async {
    List<Map<String, dynamic>>? _tempLocationData = context.read<StoreProvider>().locationData;
    EasyLoading.show();

    bool serviceEnabled;
    LocationPermission permission;
    String message;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if(!serviceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      message = '未能成功定位';
      showNoIconMessageDialog(message); 
      setState(() {
        _locationData = _tempLocationData;
      });
      EasyLoading.dismiss();
      return;
    }

    Position _currentPosition = await Geolocator.getCurrentPosition();
    double distanceInMeters;

    if(_tempLocationData == null) return;
    for(int i = 0; i < _tempLocationData.length; i++){
      distanceInMeters = Geolocator.distanceBetween(
        _currentPosition.latitude, 
        _currentPosition.longitude, 
        double.parse(_tempLocationData[i]['lat']), 
        double.parse(_tempLocationData[i]['lng']), 
      );
      // print('distance: $distanceInMeters');
      _tempLocationData[i]['distance'] = distanceInMeters.toInt();
    }
    _tempLocationData.sort((a, b) => a['distance'].compareTo(b['distance']));
    setState(() {
      _locationData = _tempLocationData.sublist(0, 10);
    });
    EasyLoading.dismiss();
  }

  Future<void> getLocations() async {
    int langId = getCurrentLangId(context);
    await context.read<StoreProvider>().loadLocations(langId);
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;

    return Column(
      children: [
        if(widget.isNearby == null || !widget.isNearby!)
        Container(
          width: double.infinity,
          child: Row(
            children: [
              StoreSearchSelect(
                name: 'area',
                value: _area,
                // actionText: '確定',
                actionText: T.storeSearchAreaSelectActionText,
                // placeholder: '選擇區域',
                placeholder: T.storeSearchAreaSelectPlaceholder,
                options: _areaData ?? [],
                onChange: (newValue){
                  setState(() {
                    _area = newValue;
                    _district = null;
                  });
                  updateLocationData();
                }
              ),
              StoreSearchSelect(
                name: 'district',
                value: _district,
                // actionText: '確定',
                actionText: T.storeSearchDistrictSelectActionText,
                // placeholder: '選擇地區',
                placeholder: T.storeSearchDistrictSelectPlaceholder,
                options: (_area != null) 
                ? _districtData?.where((_district) => _district['id'] == _area).toList() ?? [] 
                : _districtData ?? [],
                onChange: (newValue){
                  setState(() {
                    _district = newValue;
                  });
                  updateLocationData();
                }
              ),
              StoreSearchSelect(
                name: 'store',
                value: _store,
                // actionText: '確定',
                actionText: T.storeSearchStoreSelectActionText,
                // placeholder: '選擇店鋪',
                placeholder: T.storeSearchStoreSelectPlaceholder,
                options: _storeData ?? [],
                onChange: (newValue){
                  setState(() {
                    _store = newValue;
                  });
                  updateLocationData();
                }
              ),
            ],
          ),
        ),
        Expanded(
          // child: SingleChildScrollView(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //       vertical: 15,
          //       horizontal: 15  
          //     ),
          //     child: Column(
          //       children: List.generate(
          //         _locationData?.length ?? 0, 
          //         (index) => StoreCard(
          //           store: _locationData![index]
          //         )
          //       )
          //     ),
          //   ),
          // ),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15  
            ),
            itemCount: _locationData?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return StoreCard(
                store: _locationData![index]
              );
            }
          )
        ),
      ],
    );
  }
}