import 'package:flutter/material.dart';
import 'db_provider.dart';

class FavoriteSongsProvider extends ChangeNotifier {


  Future<void> insertFavoriteSong(String title, String lyrics) async {
    DBProvider.db.insertFavoriteSong(title, lyrics);
    await getFavorites();
    notifyListeners();
  }

  Future<void> deleteFavoriteSong(String title) async {
    DBProvider.db.deleteFavoriteSong(title);
    await getFavorites();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final data = await DBProvider.db.getFavorites();
    return data;
  }

  Future<void> insertFavoriteSongsHimnos(String title, String lyrics) async {
    DBProvider.db.insertFavoriteSongsHimnos(title, lyrics);
    await getFavoritesSongsHimnos();
    notifyListeners();
  }

  Future<void> deleteFavoriteSongsHimnos(String title) async {
    DBProvider.db.deleteFavoriteSongsHimnos(title);
    await getFavoritesSongsHimnos();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getFavoritesSongsHimnos() async {
    final data = await DBProvider.db.getFavoritesSongsHimnos();
    return data;
  }
}
