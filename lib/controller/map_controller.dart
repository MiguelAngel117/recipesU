import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipes/helpers/asset_to_bytes.dart';
import 'package:recipes/utils/map_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class MapController extends ChangeNotifier {
  final CameraPosition valueInitialCameraPosition = const CameraPosition(
    target: LatLng(5.552411084154579, -73.35289082337887),
    zoom: 15,
  );

  BitmapDescriptor? _restaurantIcon;
  BitmapDescriptor? _locationIcon;
  Position? _currentLocation;
  final Map<MarkerId, Marker> _markers = {};
  final markersController = StreamController<String>.broadcast();

  Set<Marker> get markers => _markers.values.toSet();
  Stream<String> get onMarketTab => markersController.stream;

  MapController() {
    _loadIcons();
    _loadSavedMarkers();
    _getCurrentLocation();
  }

  Future<void> _loadIcons() async {
    _restaurantIcon = await _loadIcon('assets/icons/restaurant.png');
    _locationIcon = await _loadIcon('assets/icons/location.png');
  }

  Future<BitmapDescriptor> _loadIcon(String path) async {
    final bytes = await assetToBytes(path, width: 64);
    return BitmapDescriptor.fromBytes(bytes);
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _checkPermission();
    if (!hasPermission) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentLocation = position;

    _addCurrentLocationMarker();

    // Escuchar actualizaciones de ubicación
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((newPosition) {
      _currentLocation = newPosition;
      _updateCurrentLocationMarker();
    });
  }

  Future<bool> _checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void _addCurrentLocationMarker() {
    if (_currentLocation == null) return;

    final markerId = const MarkerId('current_location');
    final marker = Marker(
      markerId: markerId,
      position: LatLng(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
      ),
      icon: _locationIcon ?? BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: 'Mi Ubicación'),
    );

    _markers[markerId] = marker;
    notifyListeners();
  }

  void _updateCurrentLocationMarker() {
    if (_currentLocation == null) return;

    final markerId = const MarkerId('current_location');
    _markers[markerId] = Marker(
      markerId: markerId,
      position: LatLng(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
      ),
      icon: _locationIcon ?? BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: 'Mi Ubicación'),
    );

    notifyListeners();
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
    _saveMarkers();
  }

  Future<void> _saveMarkers() async {
    final prefs = await SharedPreferences.getInstance();
    final markerData = _markers.values
        .where((marker) => marker.markerId.value != 'current_location')
        .map((marker) => {
              'id': marker.markerId.value,
              'latitude': marker.position.latitude,
              'longitude': marker.position.longitude,
            })
        .toList();
    prefs.setString('saved_markers', jsonEncode(markerData));
  }

  Future<void> _loadSavedMarkers() async {
    final prefs = await SharedPreferences.getInstance();
    final markerData = prefs.getString('saved_markers');
    if (markerData != null) {
      final List<dynamic> markerList = jsonDecode(markerData);
      for (final item in markerList) {
        final markerId = MarkerId(item['id']);
        final marker = Marker(
          markerId: markerId,
          position: LatLng(item['latitude'], item['longitude']),
          icon: _restaurantIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Restaurante'),
        );
        _markers[markerId] = marker;
      }
      notifyListeners();
    }
  }

  String getStyle() => mapStyle;

  @override
  void dispose() {
    markersController.close();
    super.dispose();
  }
}
