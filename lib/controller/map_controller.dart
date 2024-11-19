import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipes/helpers/asset_to_bytes.dart';
import 'package:recipes/utils/map_style.dart';

class MapController extends ChangeNotifier {
  final CameraPosition valueInitialCameraPosition = const CameraPosition(
    target: LatLng(5.552411084154579, -73.35289082337887),
    zoom: 15,
  );

  BitmapDescriptor? _restaurantIcon;
  final Map<MarkerId, Marker> _markers = {};
  final markersController = StreamController<String>.broadcast();

  Set<Marker> get markers => _markers.values.toSet();
  Stream<String> get onMarketTab => markersController.stream;

  MapController() {
    _loadRestaurantIcon();
  }

  Future<void> _loadRestaurantIcon() async {
    _restaurantIcon = await _loadIcon('assets/icons/restaurant.png');
  }

  Future<BitmapDescriptor> _loadIcon(String path) async {
    final bytes = await assetToBytes(path, width: 64);
    return BitmapDescriptor.fromBytes(bytes);
  }

  void addRestaurantMarker(LatLng position) {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);

    final marker = Marker(
      markerId: markerId,
      position: position,
      icon: _restaurantIcon ?? BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Restaurante',
        snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
      ),
      onTap: () {
        markersController.sink.add(id);
      },
    );

    _markers[markerId] = marker;
    notifyListeners();
  }

  String getStyle() => mapStyle;

  @override
  void dispose() {
    markersController.close();
    super.dispose();
  }
}
