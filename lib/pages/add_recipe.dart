import 'dart:io'; // Para manejar archivos de imagen
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para agregar imágenes
import 'package:recipes/models/combined_model.dart'; // Importa tu modelo para el DatePicker
import 'package:recipes/widgets/add_expenses/bs_category.dart';
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
  XFile? _image;
  final CombinedModel _combinedModel =
      CombinedModel(day: 0); // Inicializar modelo para el DatePicker

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica para guardar la receta
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receta guardada')),
      );
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
                // Campo para el nombre de la receta
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

                // Campo para la descripción
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

                // Usar DatePicker personalizado
                DatePicker(cModel: _combinedModel),
                const SizedBox(height: 16),

                // Campo para agregar imagen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? const Text('No se ha seleccionado imagen')
                        : Image.file(
                            File(
                                _image!.path), // Mostrar la imagen seleccionada
                            width: 100,
                            height: 100,
                          ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Agregar imagen'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Botón para guardar
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
