import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<Map<dynamic, dynamic>> _getFavoriteList = [];

  List<Map<dynamic, dynamic>> get favoriteList => _getFavoriteList;

  set setFavoriteList(List<Map<dynamic, dynamic>> value) {
    _getFavoriteList = value;
    print('FavoriteProvider: $favoriteList');
    notifyListeners();
  }
}