import 'dart:ui';
import 'package:flutter/material.dart';

/// App 이 Dark, Light Mode 인지 분별 하는 provider
class DarkTheme with ChangeNotifier {
  bool _isDarkMode = PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  bool get isDark => _isDarkMode;
  
  /// [isDark] - bool type, DarkMode 이면 true, 아니면 false
  void changeDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
