import 'dart:io'; // Para manejar archivos locales
import 'package:flutter/material.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/pages/edit_recipe_page.dart'; // Importa la página de edición

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<RecipeModel> recipes = [];
  bool isLoading = true; // Indica si está cargando los datos
  String? errorMessage; // Mensaje de error en caso de fallo

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      List<RecipeModel> loadedRecipes = await RecipeDatabase.db.getRecipes();
      setState(() {
        recipes = loadedRecipes;
        isLoading = false; // Deja de cargar si se obtienen recetas
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error al cargar recetas: ${error.toString()}';
        isLoading = false;
      });

      // Opcionalmente, puedes navegar a una página de error después de un retraso
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ErrorPage()), // Página de error
        );
      });
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await RecipeDatabase.db.deleteRecipe(id);
      loadRecipes(); // Recargar recetas después de eliminar
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error al eliminar receta: ${error.toString()}')),
      );
    }
  }

  Future<void> editRecipe(RecipeModel recipe) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditRecipePage(recipe: recipe), // Navegar a la página de edición
      ),
    );
    loadRecipes(); // Recargar recetas después de la edición
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Recetas'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Indicador de carga
            )
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: recipe.imagePath.isNotEmpty &&
                                File(recipe.imagePath).existsSync()
                            ? Image.file(
                                File(recipe
                                    .imagePath), // Mostrar imagen si existe
                                width: 100,
                                height: 100,
                              )
                            : const Icon(Icons.image,
                                size: 50), // Icono si no hay imagen
                        title: Text(recipe.name),
                        subtitle: Text(recipe.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                editRecipe(recipe); // Editar la receta
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Eliminar Receta'),
                                      content: const Text(
                                          '¿Estás seguro de que deseas eliminar esta receta?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cierra el diálogo
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Eliminar'),
                                          onPressed: () {
                                            deleteRecipe(recipe
                                                .id!); // Elimina la receta
                                            Navigator.of(context)
                                                .pop(); // Cierra el diálogo
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Aquí puedes navegar a una página de detalles
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)));
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hubo un problema al cargar las recetas.',
              style: TextStyle(fontSize: 18, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresa a la página anterior
              },
              child: const Text('Intentar de nuevo'),
            ),
          ],
        ),
      ),
    );
  }
}
