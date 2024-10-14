import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';

class FavoriteRecipesPage extends StatelessWidget {
  final List<Map<String, String>> recipes = [
    {
      'image': 'assets/images/food.jpeg',
      'title': 'Sunny Egg & Toast Avocado',
      'author': 'Alice Fala',
      'time': '25 Min',
      'ingredients': '1 Beef, 2 Noodles',
    },
    {
      'image': 'assets/images/food.jpeg',
      'title': 'Bowl of noodle with beef',
      'author': 'James Spader',
      'time': '25 Min',
      'ingredients': '1 Beef, 2 Noodles',
    },
    {
      'image': 'assets/images/food.jpeg',
      'title': 'Easy homemade beef burger',
      'author': 'Agnes',
      'time': '25 Min',
      'ingredients': '1 Beef, 2 Noodles',
    },
    {
      'image': 'assets/images/food.jpeg',
      'title': 'Half boiled egg sandwich',
      'author': 'Natalia Luca',
      'time': '25 Min',
      'ingredients': '1 Beef, 2 Noodles',
    },
    {
      'image': 'assets/images/food.jpeg',
      'title': 'Sunny side up with avocado',
      'author': 'Navabi Balaqis',
      'time': '25 Min',
      'ingredients': '1 Beef, 2 Noodles',
    },
    {
      'image': 'assets/images/food.jpeg',
      'title': 'Sandwich with strawberry jam',
      'author': 'Alice Fala',
      'time': '15 Min',
      'ingredients': '2 Tortilla Chips, 1 Avocado, 9 Red Cabbage',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas Favoritas'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/recipeDetail',
                arguments: recipes[index],
              );
            },
            child: RecipeCard(
              image: recipes[index]['image']!,
              title: recipes[index]['title']!,
              author: recipes[index]['author']!,
            ),
          );
        },
      ),
    );
  }
}
