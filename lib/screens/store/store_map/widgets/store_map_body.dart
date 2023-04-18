import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreMapBody extends StatefulWidget {
  Map<String, dynamic> store;

  StoreMapBody({ 
    Key? key,
    required this.store
  }) : super(key: key);

  @override
  _StoreMapBodyState createState() => _StoreMapBodyState();
}

class _StoreMapBodyState extends State<StoreMapBody> {
  late final CameraPosition cameraPosition;
  late final LatLng position;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initPosition();
    initCamera();
  }

  void initPosition(){
    position = LatLng(double.parse(widget.store['lat']), double.parse(widget.store['lng']));
  }

  void initCamera(){
    cameraPosition = CameraPosition(
      bearing: 50,
      target: position,
      tilt: 0,
      zoom: 15
    );
  }
  
  void onMapCreated(GoogleMapController controller){
    setState(() {
      controller.showMarkerInfoWindow(MarkerId('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: {
        Marker(
          markerId: MarkerId('1'),
          position: position,
          infoWindow: InfoWindow(
            title: '${widget.store['storeId']}',
            snippet: '${widget.store['shopName']}'
          )
        )
      },
      initialCameraPosition: cameraPosition,
      onMapCreated: onMapCreated,
    );
  }
}