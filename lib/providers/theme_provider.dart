import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //TODO: Implementar el cambio de tema
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkMode})
      : currentTheme = isDarkMode ? _darkTheme : _lightTheme;

  static final ThemeData _lightTheme = ThemeData.light().copyWith(
      // primaryColor: Colors.indigo,
      // appBarTheme: AppBarTheme(
      //   color: Colors.brown[400],
      // ),

      );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
      // primaryColor: Colors.indigo,
      // appBarTheme: AppBarTheme(
      //   color: Colors.indigo,
      // ),

      );

  setLightMode() {
    currentTheme = _lightTheme;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = _darkTheme;
    notifyListeners();
  }
}
