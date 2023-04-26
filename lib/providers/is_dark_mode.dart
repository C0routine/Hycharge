import 'package:flutter/material.dart';

class IsDarkMode with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
