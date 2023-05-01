import 'package:flutter/material.dart';

//TODO singleton 필요
/// 앱에서 사용하는 Color 정의
class AppColor {
  // App 에서 사용하는 모든 Color 정의.
  static const Color white = Colors.white;
  static const Color black = Color.fromRGBO(32, 32, 32, 1);
  static const Color blue = Color.fromRGBO(131, 167, 252, 1);
  static const Color grey = Color.fromRGBO(96, 96, 96, 1);

  // middle energe
  static const Color skyBlue = Color.fromRGBO(136, 192, 225, 1);
  static const Color orange = Color.fromRGBO(249, 187, 94, 1);
  static const Color red = Color.fromRGBO(236, 113, 113, 1);

  // 각 상황에 맞는 Color 정의, [isDark] 를 통해서 dark, light 모드 확인 후 각 모드에 맞는 Color return.

  /// background Color
  static Color background(bool isDark) => isDark ? black : white;

  /// disable 비활성화 상태일때 Color
  static Color disableColor = grey;

  /// enable 활성화 상태일때 Color
  static Color enableColor = blue;
}
