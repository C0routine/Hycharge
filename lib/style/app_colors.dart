import 'package:flutter/material.dart';

//TODO singleton 필요
/// 앱에서 사용하는 Color 정의
class AppColor {
  // App 에서 사용하는 모든 Color 정의.
  static const Color black = Color.fromRGBO(32, 32, 32, 1);
  static const Color grey = Color.fromRGBO(96, 96, 96, 1);

  // 각 상황에 맞는 Color 정의, [isDark] 를 통해서 dark, light 모드 확인 후 각 모드에 맞는 Color return.

  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF83A7FC);
  static const Color lightBlue = Color(0xFFE1E9FF);
  static const Color green = Color(0xFF9BDFA5);
  static const Color orange = Color(0xFFFCBE61);
  static const Color red = Color(0xFFFA8080);

  /// background Color
  static Color background(bool isDark) => isDark ? black : white;

  /// Text Color
  static Color text(bool isDark) => isDark ? white : black;

  /// disable status Color
  static Color disableColor = grey;

  /// enable status Color
  static Color enableColor = blue;

  /// marker high energy status color
  static Color high = green;

  /// marker middle energy status color
  static Color middle = orange;

  /// marker low energy status color
  static Color low = red;
}
