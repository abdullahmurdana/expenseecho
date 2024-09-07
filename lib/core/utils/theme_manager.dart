import 'package:flutter/material.dart';
import 'package:expenseecho/data/services/shared_preferences_handler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode);
    notifyListeners();
  }

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveTheme(_themeMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    String? themeString = await SharedPreferencesHandler.getTheme();
    if (themeString != null) {
      _themeMode = _themeModeFromString(themeString);
      notifyListeners();
    }
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    await SharedPreferencesHandler.saveTheme(_themeModeToString(themeMode));
  }

  ThemeMode _themeModeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
      default:
        return 'light';
    }
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,

  // Define other light theme properties here
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,

  // Define other dark theme properties here
);
