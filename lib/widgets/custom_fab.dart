import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recipes/pages/add_recipe.dart';
import 'package:recipes/pages/recipe_list_page.dart';
import 'package:recipes/utils/page_animation_routes.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childButtons = [];

    childButtons.add(SpeedDialChild(
        child: const Icon(Icons.remove),
        backgroundColor: Colors.red,
        label: 'Borrar',
        labelStyle: const TextStyle(fontSize: 18.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecipeListPage(),
            ),
          );
          print('Borra');
        }));

    childButtons.add(SpeedDialChild(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        label: 'Crear receta',
        labelStyle: const TextStyle(fontSize: 18.0),
        onTap: () {
          Navigator.push(
              context,
              PageAnimationRoutes(
                  widget: const AddRecipe(), ejex: 0.8, ejey: 0.8));
        }));
    return SpeedDial(
      icon: Icons.cookie_rounded,
      activeIcon: Icons.close,
      children: childButtons,
      spacing: 10.0,
      childMargin: const EdgeInsets.symmetric(horizontal: 6.0),
      childrenButtonSize: const Size(60.0, 60.0),
    );
  }
}
