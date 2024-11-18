
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipes/helpers/asset_to_bytes.dart';
import 'package:recipes/utils/map_style.dart';

class MapController extends ChangeNotifier{
  final CameraPosition valueInitialCameraPosition = const CameraPosition(target: LatLng(5.552411084154579, -73.35289082337887),zoom: 15);
 final marketIcon = Completer<BitmapDescriptor>();
 MapController(){
  assetToBytes('assets/market_01.png', width: 45).then((value){
    final bitmap = BitmapDescriptor.bytes(value);
    marketIcon.complete(bitmap);
  });
 }
 final Map<MarkerId, Marker> _markers = {};
 Set<Marker> get markers => _markers.values.toSet();
  final markersController = StreamController<String>.broadcast() ;
  Stream<String> get onMarketTab => markersController.stream;
 String getStyle() => mapStyle;

 void onTap(LatLng point) async{
  final id = _markers.length.toString();
  final markerId = MarkerId(id);
  final icon = await marketIcon.future;
  final marker = Marker(
    markerId: markerId, 
    position: point,
    draggable: true,
    icon: icon,
  onTap:() {
    markersController.sink.add(id);
  },
  onDragEnd: (newPosition) {});
  
  _markers[markerId] = marker;
  notifyListeners();
 }

 @override
 void dispose(){
  markersController.close();
  super.dispose();
 }
}