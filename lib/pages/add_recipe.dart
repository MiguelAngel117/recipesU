import 'dart:io'; // Para manejar archivos de imagen
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para agregar imágenes
import 'package:recipes/models/combined_model.dart'; // Importa tu modelo para el DatePicker
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/widgets/add_expenses/bs_category.dart';
import 'package:recipes/widgets/add_recipes/image_picker_widget.dart';
import 'package:recipes/widgets/date_picker.dart'; // Importa tu clase DatePicker

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _imagePath; // Almacena la ruta de la imagen
  final CombinedModel _combinedModel = CombinedModel(day: 0);

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = RecipeModel(
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: _imagePath ?? '', // Usa la ruta almacenada
        category: _combinedModel.category,
        year: _combinedModel.year,
        month: _combinedModel.month,
        day: _combinedModel.day,
      );

      final result = await RecipeDatabase.db.insertRecipe(recipe);

      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receta guardada')),
        );

        _nameController.clear();
        _descriptionController.clear();
        setState(() {
          _imagePath = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la receta')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Receta'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la receta',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre de la receta';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                BsCategory(cModel: _combinedModel),
                const SizedBox(height: 16),

                DatePicker(cModel: _combinedModel),
                const SizedBox(height: 16),

                // Usa el nuevo widget de selección de imagen
                ImagePickerWidget(
                  onImageSelected: (path) {
                    setState(() {
                      _imagePath = path; // Almacena la ruta de la imagen
                    });
                  },
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _saveRecipe,
                  child: const Text('Guardar receta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
