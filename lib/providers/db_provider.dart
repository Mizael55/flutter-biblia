import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    // path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'favorites.db');
    // print(path);

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE favorites (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idx INTEGER,
          testament TEXT,
          book TEXT,
          boookNumber INTEGER,
          verse INTEGER,
          chapter INTEGER,
          text TEXT,
          title TEXT
        )
        ''');

        // crea la tabla de favoritos
        await db.execute('''
        CREATE TABLE favoritesSongs (
        id INTEGER PRIMARY KEY,
        title TEXT,
        lyrics TEXT
      )
      ''');

       await db.execute('''
        CREATE TABLE favoritesSongsHimnos (
        id INTEGER PRIMARY KEY,
        title TEXT,
        lyrics TEXT
      )
    ''');
      },
    );
  }

  Future<void> addFavorite(fav) async {
    final db = await database;
    await db!.insert('favorites', fav);
  }

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('favorites');
    print(maps);
    return maps.isNotEmpty ? maps : [];
  }

  deleteFavorite(id) async {
    final db = await database;
    final data =
        await db!.delete('favorites', where: 'id = ?', whereArgs: [id]);
    print(data);
  }

  Future<void> insertFavoriteSong(String title, String lyrics) async {
    final db = await database;
    await db!.insert(
      'favoritesSongs',
      {'title': title, 'lyrics': lyrics},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavoriteSong(String title) async {
    final db = await database;
    await db!.delete(
      'favoritesSongs',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    print(await db!.query('favoritesSongs'));
    return await db.query('favoritesSongs');
  }

 Future<void> insertFavoriteSongsHimnos(String title, String lyrics) async {
    final db = await database;
    await db!.insert(
      'favoritesSongsHimnos',
      {'title': title, 'lyrics': lyrics},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavoriteSongsHimnos(String title) async {
    final db = await database;
    await db!.delete(
      'favoritesSongsHimnos',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<List<Map<String, dynamic>>> getFavoritesSongsHimnos() async {
    final db = await database;
    return await db!.query('favoritesSongsHimnos');
  }

}
