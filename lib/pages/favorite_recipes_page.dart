import 'package:flutter/material.dart';
import 'package:recipes/pages/DetailPage.dart';
import 'package:recipes/utils/Listfood.dart';
import '../widgets/recipe_card.dart';
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/models/recipe_model.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({super.key});

  @override
  _FavoriteRecipesPageState createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Favoritas'),
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(child: Text('No tienes recetas favoritas.'))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          food: Recipe(
                            name: recipe.name,
                            category: recipe.category,
                            liked: recipe.liked,
                            image: recipe.imagePath.isNotEmpty
                                ? recipe.imagePath
                                : 'assets/images/fallback_image.png',
                            ingredients: recipe.ingredients,
                            steps: recipe.steps,
                            description: '',
                          ),
                        ),
                      ),
                    );
                  },
                  child: RecipeCard(
                    image: recipe.imagePath.isNotEmpty
                        ? recipe.imagePath
                        : 'assets/images/fallback_image.png',
                    title: recipe.name,
                    author: recipe.category ?? 'Autor desconocido',
                  ),
                );
              },
            ),
    );
  }
}
