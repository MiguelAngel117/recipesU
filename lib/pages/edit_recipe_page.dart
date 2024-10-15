import 'dart:io'; // Para manejar archivos de imagen
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para agregar imágenes
import 'package:recipes/models/combined_model.dart';
import 'package:recipes/models/recipe_model.dart'; // Modelo de receta
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/widgets/add_expenses/bs_category.dart'; // Selector de categoría
import 'package:recipes/widgets/date_picker.dart'; // Selector de fecha personalizado

class EditRecipePage extends StatefulWidget {
  final RecipeModel recipe; // Recibe la receta que se va a editar

  const EditRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _image;
  late CombinedModel _combinedModel; // Modelo para DatePicker y categoría

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los datos existentes de la receta
    _nameController.text = widget.recipe.name;
    _descriptionController.text = widget.recipe.description;
    _combinedModel = CombinedModel(
      category: widget.recipe.category,
      year: widget.recipe.year,
      month: widget.recipe.month,
      day: widget.recipe.day,
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future<void> _updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      // Crear una instancia de RecipeModel actualizada
      final updatedRecipe = RecipeModel(
        id: widget.recipe.id, // Mantener el ID de la receta
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: _image?.path ??
            widget.recipe
                .imagePath, // Mantener la imagen anterior si no se selecciona una nueva
        category: _combinedModel.category,
        year: _combinedModel.year,
        month: _combinedModel.month,
        day: _combinedModel.day,
      );

      // Actualizar en la base de datos
      final result = await RecipeDatabase.db.updateRecipe(updatedRecipe);

      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receta actualizada correctamente')),
        );
        Navigator.pop(context); // Regresar a la pantalla anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar la receta')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Receta'),
        backgroundColor: Colors.blue, // Evitar valores nulos
      ),
      body: Center(
        child: SingleChildScrollView(
          // Añadir un SingleChildScrollView aquí
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

                  // Selector de categoría
                  BsCategory(cModel: _combinedModel),
                  const SizedBox(height: 16),

                  // Selector de fecha personalizado
                  DatePicker(cModel: _combinedModel),
                  const SizedBox(height: 16),

                  // Campo para agregar o mostrar la imagen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null
                          ? widget.recipe.imagePath.isNotEmpty
                              ? Image.file(
                                  File(widget.recipe
                                      .imagePath), // Mostrar la imagen existente
                                  width: 100,
                                  height: 100,
                                )
                              : const Text('No se ha seleccionado imagen')
                          : Image.file(
                              File(_image!
                                  .path), // Mostrar la nueva imagen seleccionada
                              width: 100,
                              height: 100,
                            ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                            //backgroundColor:   Colors.blue, // Color de fondo del botón
                            ),
                        child: const Text('Cambiar imagen'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Botón para guardar cambios
                  ElevatedButton(
                    onPressed: _updateRecipe,
                    style: ElevatedButton.styleFrom(
                        //backgroundColor: Colors.green, // Color de fondo del botón
                        ),
                    child: const Text('Guardar cambios'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
