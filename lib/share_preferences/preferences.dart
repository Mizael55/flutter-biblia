import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static bool isDarkMode = false;
  static double fontSize = 16;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkMode {
    isDarkMode = _prefs.getBool('darkMode') ?? false;
    return isDarkMode;
  }

  static set darkMode(bool value) {
    isDarkMode = value;
    _prefs.setBool('darkMode', value);
  }

  static double get size {
    fontSize = _prefs.getDouble('size') ?? 16;
    return fontSize;
  }

  static set size(double value) {
    fontSize = value;
    _prefs.setDouble('size', value);
  }

}