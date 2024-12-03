import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/providers/recipe_db.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends State<RecipePage> {

  List<RecipeModel> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteRecipes();
  }

  Future<void> loadFavoriteRecipes() async {
    List<RecipeModel> recipes = await RecipeDatabase.db.getRecipes();
    setState(() {
      favoriteRecipes =
          recipes.where((recipe) => recipe.liked == true).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return favoriteRecipes.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.no_food,
                  size: 100,
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                const Text(
                  'No hay recetas en tu perfil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Agrega tus recetas favoritas para verlas aquí.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                RecipeModel recipe = favoriteRecipes[index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      recipe.imagePath.isNotEmpty
                          ? recipe.imagePath
                          : 'assets/images/Error Wallpaper.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/Error Wallpaper.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
  }
}