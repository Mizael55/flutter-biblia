import 'package:biblia/db/db.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<Map<dynamic, dynamic>> _getFavoriteList = [];

  List<Map<dynamic, dynamic>> get favoriteList => _getFavoriteList;

  setFavoriteList(dynamic value) async{
    await DBProvider.db.addFavorite(value);
    await getAllFavorites();
  }

  getAllFavorites() async {
    _getFavoriteList = await DBProvider.db.getAllFavorites();
    notifyListeners();
  }

  // eliminar de favoritos
  deleteFavorite(dynamic value) async {
    await DBProvider.db.deleteFavorite(value);
    await getAllFavorites();
  }
}