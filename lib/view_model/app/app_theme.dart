import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/view_model/app/app_colors.dart';

class AppTheme {
  /// LightMode Theme
  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.white,
      brightness: Brightness.light,
      textTheme: lightTextTheme,
    );
  }

  /// DarkMode Theme
  static ThemeData dark() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.black,
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
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
}
