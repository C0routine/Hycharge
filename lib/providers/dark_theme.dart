import 'package:flutter/material.dart';

/// App 이 Dark, Light Mode 인지 분별 하는 provider
class DarkTheme with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDark => _isDarkMode;

  /// [isDark] - bool type, DarkMode 이면 true, 아니면 false
  void changeMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
