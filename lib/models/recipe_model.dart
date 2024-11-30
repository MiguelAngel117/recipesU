import 'dart:convert';

class RecipeModel {
  RecipeModel({
    this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.year,
    required this.month,
    required this.day,
    required this.ingredients,
    required this.steps,
  });

  int? id;
  String name;
  String description;
  String imagePath; // Ruta de la imagen
  String category;
  int year;
  int month;
  int day;

  List<String> ingredients; // Ahora con tipo explícito
  List<String> steps;

  // Constructor para crear el modelo desde un JSON
  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imagePath: json["imagePath"],
        category: json["category"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        ingredients: json["ingredients"] != null
            ? List<String>.from(jsonDecode(json["ingredients"]))
            : [], // Convierte de JSON string a List<String>
        steps: json["steps"] != null
            ? List<String>.from(jsonDecode(json["steps"]))
            : [], // Convierte de JSON string a List<String> // Manejo de null y conversión a List<String>
      );

  // Método para convertir el modelo a un JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imagePath": imagePath,
        "category": category,
        "year": year,
        "month": month,
        "day": day,
        "ingredients":
            jsonEncode(ingredients), // Convierte List<String> a JSON string
        "steps": jsonEncode(steps), // Convierte List<String> a JSON string
      };
}
