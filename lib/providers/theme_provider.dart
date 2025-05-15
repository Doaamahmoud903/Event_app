import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme;

  ThemeProvider(this.currentTheme);

  ThemeMode get themeMode => currentTheme;

  void changeTheme(ThemeMode newThemeMode) async {
    if (currentTheme == newThemeMode) return;
    currentTheme = newThemeMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', newThemeMode == ThemeMode.dark ? 'dark' : 'light');
  }
}

