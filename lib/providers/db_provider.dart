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
}
