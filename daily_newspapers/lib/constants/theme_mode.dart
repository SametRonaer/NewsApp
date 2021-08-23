import 'package:flutter/material.dart';

class ThemesOfApp extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool _isDarkMode = false;

  Future<void> setMode() async {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
