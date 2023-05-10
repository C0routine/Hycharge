import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/app/app_colors.dart';

class AppTheme {
  /// LightMode Theme
  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.white,
      brightness: Brightness.light,
      textTheme: lightDartTextTheme(false),
    );
  }

  /// DarkMode Theme
  static ThemeData dark() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.black,
      brightness: Brightness.dark,
      textTheme: lightDartTextTheme(true),
    );
  }

  /// LightMode & DarkMode Text Theme
  static TextTheme lightDartTextTheme(bool dark) {
    return TextTheme(
      // normal title Text
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: dark ? AppColor.white : AppColor.black,
        overflow: TextOverflow.clip,
      ),

      // normal text
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: dark ? AppColor.white : AppColor.black,
        overflow: TextOverflow.clip,
      ),

      // small text (hint)
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: dark ? AppColor.white : AppColor.black,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
