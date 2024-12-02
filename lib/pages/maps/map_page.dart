import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recipes/controller/map_controller.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_) => MapController(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Mapa de Restaurantes")),
        body: Consumer<MapController>(
          builder: (_, controller, __) => GoogleMap(
            initialCameraPosition: controller.valueInitialCameraPosition,
            markers: controller.markers,
            onTap: (point) async {
              final name = await _showNameDialog(context);
              if (name != null && name.isNotEmpty) {
                controller.addRestaurantMarker(point, name);
              }
            },
          ),
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Toque el mapa para agregar un restaurante.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<String?> _showNameDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nombre del Restaurante'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Ingrese el nombre'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
