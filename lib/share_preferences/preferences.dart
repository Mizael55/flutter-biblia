import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static bool isDarkMode = true;
  static double fontSize = 16;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkMode {
     return _prefs.getBool('isDarkMode') ?? isDarkMode;
  }

  static set darkMode(bool value) {
    isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }

  static double get getSize {
    return  _prefs.getDouble('size') ?? fontSize;
  }

  static set size(double value) {
    fontSize = value;
    _prefs.setDouble('size', value);
  }

}