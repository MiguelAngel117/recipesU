import 'package:flutter/material.dart';
import 'package:recipes/pages/DetailPage.dart';
import 'package:recipes/utils/Listfood.dart';

class UserRecipesWidget extends StatefulWidget {
  const UserRecipesWidget({super.key});

  @override
  State<UserRecipesWidget> createState() => _UserRecipesWidget();
}

class _UserRecipesWidget extends State<UserRecipesWidget> {
  final recipes = RecipeList().listFood;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextButton(
                onPressed: () {
                  _showFavorites(context);
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.75,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return _buildRecipeCard(recipes[index], () {
                _showRecipeDetails(context, recipes[index]);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(recipe, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              food: recipe,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la receta
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.asset(
                recipe.image!,
                width: double.infinity,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            // Título de la receta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                recipe.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Imagen del usuario y su nombre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(recipe.userImage!),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    recipe.userName!,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  void _showFavorites(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'My Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return _buildRecipeCard(recipes[index], () {
                      _showRecipeDetails(context, recipes[index]);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRecipeDetails(BuildContext context, recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(recipe['recipeTitle']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150.0,
                width: double.infinity,
                child: Image.asset(
                  recipe['recipeImage']!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Recipe by ${recipe.userName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
