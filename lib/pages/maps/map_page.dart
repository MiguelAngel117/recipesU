import 'package:flutter/material.dart';
import  'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recipes/controller/map_controller.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_) {
        final controller = MapController();
        controller.onMarketTab.listen((String id){
          print("point:  $id");
        });
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Google Map")),
        body: Consumer<MapController>(
          builder: (_, controller, __) => GoogleMap(
            initialCameraPosition: controller.valueInitialCameraPosition,
            markers: controller.markers,
            style: controller.getStyle(),
            onTap: controller.onTap,),
        ),
      ),
    );

  }
}