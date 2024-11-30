import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipes/providers/recipe_db.dart';
import 'package:recipes/utils/Listfood.dart';

class DetailPage extends StatefulWidget {
  final Recipe food;

  const DetailPage({super.key, required this.food});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 200),
                  LikeButton(
                      size: 30,
                      circleColor:
                          const CircleColor(start: Colors.red, end: Colors.red),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.red,
                        dotSecondaryColor: Colors.red,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 30,
                        );
                      },
                      onTap: (isLiked) async {
                        // Aquí se cambia el estado de la receta
                        setState(() {
                          widget.food.liked =
                              !isLiked; // Actualizamos el estado de "liked"
                        });
                        debugPrint(
                            "Resultado de like ${widget.food.liked.toString()}");
                        // Ahora se guarda la receta actualizada en la base de datos
                        var result = await RecipeDatabase.db
                            .updateRecipeLike(widget.food.toRecipeModel());
                        debugPrint("Resultado de like $result");

                        return !isLiked; // Retornamos el nuevo estado de like
                      }),
                ],
              ),

              // Verifica si el archivo de imagen existe
              widget.food.image != null && File(widget.food.image).existsSync()
                  ? Image.file(File(widget.food.image))
                  : const Placeholder(
                      fallbackHeight: 200, fallbackWidth: double.infinity),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.food.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.food.ingredients.length} Ingredientes",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Tiempo de preparación: ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      "${Random().nextInt(120)} minutos",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Pestañas para ingredientes y preparación
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Ingredientes'),
                        Tab(text: 'Preparación'),
                      ],
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                    ),
                    SizedBox(
                      height: 400, // Altura de la pestaña
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Contenido de la pestaña de ingredientes
                          SingleChildScrollView(
                            child: Column(
                              children:
                                  widget.food.ingredients.map((ingredient) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          ingredient,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // Contenido de la pestaña de preparación
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < widget.food.steps.length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${i + 1}. ",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            widget.food.steps[i],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
