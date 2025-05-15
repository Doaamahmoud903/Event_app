import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLocal;

  LanguageProvider(this.currentLocal);

  void changeLocal(String newLocal) async {
    if (currentLocal == newLocal) return;
    currentLocal = newLocal;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLocal);
  }
}
