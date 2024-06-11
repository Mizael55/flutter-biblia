import 'package:flutter/material.dart';

class LetterSize extends ChangeNotifier {
  double size;

  LetterSize({
    required this.size,
  });

  double get getSize => size;

  void setSize(double value) {
    size = value;
    notifyListeners();
  }
}
