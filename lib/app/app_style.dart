import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Singleton Pattern 으로 생성. (ScreenUtilInit 후 사용해야함)
/// App 에서 사용하는 UI Style 통일을 위해 정의한 class
class AppStyle {
  static final AppStyle _appStyle = AppStyle._init();

  factory AppStyle(EdgeInsets edgeInsets) {
    return _appStyle;
  }

  AppStyle._init();

  // SafeArea 간격
  static EdgeInsets safeArea = EdgeInsets.zero;

  /// ui 간 vertical 간격
  static EdgeInsetsGeometry gapVertical = EdgeInsets.symmetric(vertical: 16.h);

  /// ui 간 horizontal 간격
  static EdgeInsetsGeometry gapHorizon = EdgeInsets.symmetric(horizontal: 16.w);

  /// ui 간 left 간격
  static EdgeInsetsGeometry gapLeft = EdgeInsets.only(left: 16.w);

  /// ui 간 right 간격
  static EdgeInsetsGeometry gapRight = EdgeInsets.only(right: 16.w);

  /// ui 간 bottom 간격
  static EdgeInsetsGeometry gapBottom = EdgeInsets.only(bottom: 16.h);

  /// 기본 ui 간 top 간격
  static EdgeInsetsGeometry gapTop = EdgeInsets.only(top: 16.h);

  /// title 과 body margin, top 간격
  static EdgeInsetsGeometry gapTitle = EdgeInsets.only(top: 5.h);

  /// ui 간 margin top 간격
  static EdgeInsetsGeometry marginTop = EdgeInsets.only(top: 30.h);

  /// 기본 padding
  static EdgeInsetsGeometry basicPadding = EdgeInsets.all(16.w);

  /// 기본 borderRadius
  static BorderRadius borderRadius = BorderRadius.circular(16.w);

  /// deep borderRadius
  static BorderRadius hardBorderRadius = BorderRadius.circular(32.w);
}
