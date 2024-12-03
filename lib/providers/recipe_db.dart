import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:recipes/utils/Listfood.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RecipeDatabase {
  static Database? _database;
  static final RecipeDatabase db = RecipeDatabase._();
  Logger logger = Logger();
  RecipeDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit(); // Inicializa el database para entornos de escritorio
      databaseFactory = databaseFactoryFfi; // Establece el factory
    }

    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "RecipeDB.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Recipe (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          imagePath TEXT,
          category TEXT,
          year INTEGER,
          month INTEGER,
          day INTEGER,
          ingredients TEXT NOT NULL, -- Almacenará JSON serializado
          steps TEXT NOT NULL,        -- Almacenará JSON serializado
          liked INTEGER NOT NULL DEFAULT 0  -- Agregamos el campo "liked"
        )
      ''');
    });
  }

  Future<String> _getImageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final imageDirectory = Directory('${directory.path}/recipe_images');
    if (!await imageDirectory.exists()) {
      await imageDirectory.create();
    }
    return imageDirectory.path;
  }

  Future<String> _saveImageLocally(File imageFile) async {
    // Obtener el directorio local para las imágenes
    final directory = await getApplicationDocumentsDirectory();
    final imageDirectory = Directory('${directory.path}/recipe_images');

    // Verifica si el directorio existe, si no lo crea
    if (!await imageDirectory.exists()) {
      await imageDirectory.create();
    }

    // Genera un nombre único para la imagen
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final localImagePath = '${imageDirectory.path}/$fileName';

    // Lee el archivo de los assets como bytes
    final byteData = await rootBundle.load(imageFile.path);
    final buffer = byteData.buffer.asUint8List();

    // Crea un archivo en el almacenamiento local y escribe los bytes
    final localFile = File(localImagePath);
    await localFile.writeAsBytes(buffer);

    return localImagePath;
  }

  Future<void> insertDefaultRecipe(RecipeModel recipe) async {
    final db = await database;

    // Guardar la imagen de la receta en el sistema de archivos
    File imageFile = File(recipe.imagePath);
    String imageName = await _saveImageLocally(imageFile);
    debugPrint('$imageName Path quemado');
    // Guardar solo el nombre del archivo de la imagen en la base de datos
    await db.insert('Recipe', {
      'name': recipe.name,
      'imagePath': imageName, // Almacena solo el nombre del archivo
      'description': recipe.description,
      'category': recipe.category,
      'year': recipe.year,
      'month': recipe.month,
      'day': recipe.day,
    });
  }

  Future<int> initializeDefaultRecipes() async {
    final defaultRecipes = RecipeList().listFood;
    int testNum = 0;
    // Insertar recetas predeterminadas
    for (var recipe in defaultRecipes) {
      // Asegurémonos de que la imagen está en el dispositivo local
      String imageName = await _saveImageLocally(File(recipe.image));
      logger.d("con una imagen ${recipe.name}");
      // Guardar la receta en la base de datos, usando solo el nombre del archivo de la imagen
      testNum = await insertRecipe(
        // Asegúrate de usar el nombre correcto de la tabla
        RecipeModel(
            name: recipe.name,
            imagePath: imageName, // Solo guardamos el nombre del archivo
            description: '',
            category: recipe.category,
            year: 0,
            month: 0,
            day: 0,
            ingredients: recipe.ingredients,
            steps: recipe.steps),
      );
    }

    debugPrint('Recetas predeterminadas insertadas en la base de datos.');

    debugPrint('Recetas después de inicializar: $defaultRecipes');

    return testNum;
  }

  Future<int> insertRecipe(RecipeModel recipe) async {
    final db = await database;
    final res = await db.insert('Recipe', recipe.toJson());
    return res;
  }

  Future<List<RecipeModel>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Recipe');

    return List.generate(maps.length, (i) {
      return RecipeModel.fromJson(maps[i]); // Convierte cada mapa a RecipeModel
    });
  }

  Future<int> updateRecipe(RecipeModel recipe) async {
    final db = await database;
    return await db.update(
      'Recipe',
      recipe.toJson(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    ); // Devuelve el número de filas afectadas
  }

  Future<int> deleteRecipe(int id) async {
    final db = await database;
    return await db.delete(
      'Recipe',
      where: 'id = ?',
      whereArgs: [id],
    ); // Devuelve el número de filas eliminadas
  }

  Future<int> updateRecipeLike(RecipeModel recipe) async {
    final db = await database;
    return await db.update(
      'Recipe',
      {'liked': recipe.liked ? 1 : 0}, // Establecemos el "like" como 1 o 0
      where: 'name = ?',
      whereArgs: [recipe.name],
    );
  }
}
