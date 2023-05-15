import 'package:flutter/material.dart';

/// 앱에서 사용하는 Color 정의
class AppColor {
  // App 에서 사용하는 모든 Color 정의.
  static const Color white = Color(0xFFFFFFFF);
  static const Color blurWhite = Color(0xFFF3F3F3);
  static const Color black = Color(0xFF202020);
  static const Color blurBlack = Color(0xFF404040);

  static const Color grey = Color(0xFF606060); // fix need
  static const Color blue = Color(0xFF83A7FC);
  static const Color green = Color(0xFF9BDFA5);
  static const Color orange = Color(0xFFFCBE61);
  static const Color red = Color(0xFFFA8080);

  // static const Color lightBlue = Color(0xFFE1E9FF);

  // 각 상황에 맞는 Color 정의, [isDark] 를 통해서 dark, light 모드 확인 후 각 모드에 맞는 Color return.

  /// background Color
  static Color background(bool isDark) => isDark ? black : white;

  /// background Blur Color (background color 와 같이 사용, hint, label background)
  static Color backgroundBlur(bool isDark) => isDark ? blurBlack : blurWhite;

  /// Text Color
  static Color text(bool isDark) => isDark ? white : black;

  /// disable status Color
  static const Color disableColor = grey;

  /// enable status Color
  static const Color enableColor = blue;

  /// marker high energy status color
  static const Color high = green;

  /// marker middle energy status color
  static const Color middle = orange;

  /// marker low energy status color
  static const Color low = red;
}
