import 'dart:io';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipe =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Recipe not found")),
        body: const Center(child: Text("No recipe data available")),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(recipe['title'] ?? 'Recipe'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Ingredients"),
              Tab(text: "Instructions"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IngredientsTab(recipe: recipe),
            InstructionsTab(
                instructions:
                    recipe['instructions'] ?? 'No instructions available'),
          ],
        ),
      ),
    );
  }
}

class IngredientsTab extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const IngredientsTab({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          recipe['image'] != null && File(recipe['image']).existsSync()
              ? Image.file(File(recipe['image']))
              : const Placeholder(
                  fallbackHeight: 200, fallbackWidth: double.infinity),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['title'] ?? 'Recipe Title',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 5),
                    Text('${recipe['time'] ?? 'Unknown'} min'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (recipe['ingredients'] != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipe['ingredients'].length,
                    itemBuilder: (context, index) {
                      final ingredient = recipe['ingredients'][index];
                      if (ingredient['name'] is String &&
                          ingredient['quantity'] is String) {
                        return ListTile(
                          leading: const Icon(Icons.check_box_outline_blank),
                          title: Text(ingredient['name']),
                          trailing: Text(ingredient['quantity']),
                        );
                      } else {
                        return const ListTile(
                          leading: Icon(Icons.error_outline),
                          title: Text('Invalid ingredient data'),
                        );
                      }
                    },
                  )
                else
                  const Text("No ingredients available"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InstructionsTab extends StatelessWidget {
  final String instructions;

  const InstructionsTab({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        instructions,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
