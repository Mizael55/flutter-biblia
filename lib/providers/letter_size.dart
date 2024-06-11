import 'package:flutter/material.dart';

class LetterSize extends ChangeNotifier {
  double _size = 16;

  double get size => _size;

  void setSize(double size) {
    _size = size;
    notifyListeners();
  }
}
