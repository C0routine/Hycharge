import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/style/app_colors.dart';

class AppTheme {
  /// LightMode Theme
  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.white,
      brightness: Brightness.light,
      textTheme: lightTextTheme,
      colorScheme: lightColorScheme,
    );
  }

  /// DarkMode Theme
  static ThemeData dark() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.black,
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
      colorScheme: darkColorScheme,
    );
  }

  /// LightMode Text Theme
  static TextTheme lightTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColor.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColor.black,
    ),
  );

  /// LightMode ColorScheme
  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.white,
    onPrimary: AppColor.white,
    secondary: AppColor.white,
    onSecondary: AppColor.white,
    error: AppColor.white,
    onError: AppColor.white,
    background: AppColor.white,
    onBackground: AppColor.white,
    surface: AppColor.white,
    onSurface: AppColor.white,
  );

  /// DarkMode Text Theme
  static TextTheme darkTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColor.white,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColor.white,
    ),
  );

  /// DarkMode ColorScheme
  static ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.black,
    onPrimary: AppColor.black,
    secondary: AppColor.black,
    onSecondary: AppColor.black,
    error: AppColor.black,
    onError: AppColor.black,
    background: AppColor.black,
    onBackground: AppColor.black,
    surface: AppColor.black,
    onSurface: AppColor.black,
  );
}
