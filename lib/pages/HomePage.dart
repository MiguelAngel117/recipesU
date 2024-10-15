import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/pages/account_page.dart';
import 'package:recipes/providers/recipe_db.dart';

import '../utils/Listfood.dart';
import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> listFood = RecipeList().listFood;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    List<RecipeModel> recipes = await RecipeDatabase.db.getRecipes();
    if (recipes.isEmpty) {
      print('Recipes se mantiene'); // Usar datos de ejemplo si no hay recetas
    } else {
      setState(() {
        listFood = recipes
            .map((recipe) => Recipe.fromRecipeModel(recipe))
            .toList(); // Actualizar el estado con las recetas
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 92, 137, 94),
      body: Center(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, Santiago 👋🏻',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.lime,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("¿Qué vas a cocinar hoy?",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(right: 20)),
                  InkWell(
                    onTap: () {
                      // Navegar a la página de cuenta al hacer clic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountPage(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/pics.jpg'),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar recetas',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              SizedBox(
                  height: 120,
                  child: ListView.builder(
                      itemCount: listFood.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.lime.shade500,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                      listFood[index].image.toString()),
                                  height: 75,
                                ),
                                Text(listFood[index].name.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        );
                      })),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Recetas populares',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Ver todo',
                            style: TextStyle(
                              color: Colors.lime,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                          itemCount: listFood.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      food: listFood[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 250,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          listFood[index].image.toString(),
                                        ),
                                        height: 100,
                                      ),
                                      Text(
                                        listFood[index].name.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      LikeButton(
                                        size: 30,
                                        circleColor: const CircleColor(
                                            start: Colors.red, end: Colors.red),
                                        bubblesColor: const BubblesColor(
                                          dotPrimaryColor: Colors.red,
                                          dotSecondaryColor: Colors.red,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            Icons.favorite,
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 30,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
