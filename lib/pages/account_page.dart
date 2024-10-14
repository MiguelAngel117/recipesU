import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final List<Map<String, String>> recipes = [
    {
      'recipeImage': 'assets/images/recipe.jpg',
      'recipeTitle': 'Delicious Pasta',
      'userImage': 'assets/user.webp',
      'userName': 'John Doe',
    },
    {
      'recipeImage': 'assets/images/recipe.jpg',
      'recipeTitle': 'Tasty Burger',
      'userImage': 'assets/user.webp',
      'userName': 'Jane Smith',
    },
    {
      'recipeImage': 'assets/images/recipe.jpg',
      'recipeTitle': 'Healthy Salad',
      'userImage': 'assets/user.webp',
      'userName': 'Chris Evans',
    },
    {
      'recipeImage': 'assets/images/recipe.jpg',
      'recipeTitle': 'Fruit Smoothie',
      'userImage': 'assets/user.webp',
      'userName': 'Emma Stone',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print('A futuro permitira editar');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/user.webp'),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Luis Santiago',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text('Recipe Developer',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                      children: const [
                        Text(
                          'My Favorites',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text('See All',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.0,
                            ))
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return _buildRecipeCard(recipes[index]);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, String> recipe) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
              recipe['recipeImage']!,
              width: double.infinity,
              height: 100.0, // Ajusta la altura de la imagen
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          // Título de la receta
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              recipe['recipeTitle']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0, // Tamaño más pequeño
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
                  backgroundImage: AssetImage(recipe['userImage']!),
                ),
                const SizedBox(width: 8.0),
                Text(
                  recipe['userName']!,
                  style: const TextStyle(
                    fontSize: 12.0, // Texto más pequeño
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
