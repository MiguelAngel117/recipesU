import 'dart:io';

import 'package:path/path.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RecipeDatabase {
  static Database? _database;
  static final RecipeDatabase db = RecipeDatabase._();

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
          day INTEGER
        )
      ''');
    });
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
}
