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
  });

  int? id;
  String name;
  String description;
  String imagePath; // Ruta de la imagen
  String category;
  int year;
  int month;
  int day;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imagePath: json["imagePath"],
        category: json["category"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imagePath": imagePath,
        "category": category,
        "year": year,
        "month": month,
        "day": day,
      };
}
