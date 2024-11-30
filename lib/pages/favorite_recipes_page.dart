import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/models/recipe_model.dart';

class FavoriteRecipesPage extends StatefulWidget {
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
      // Filtra las recetas que están marcadas como favoritas
      favoriteRecipes =
          recipes.where((recipe) => recipe.liked == true).toList();

      debugPrint("Fav  normal ${recipes[0].liked}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Favoritas'),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(child: Text('No tienes recetas favoritas.'))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/recipeDetail',
                      arguments: favoriteRecipes[index],
                    );
                  },
                  child: RecipeCard(
                    image: favoriteRecipes[index].imagePath,
                    title: favoriteRecipes[index].name,
                    author:
                        favoriteRecipes[index].category ?? 'Autor desconocido',
                  ),
                );
              },
            ),
    );
  }
}
