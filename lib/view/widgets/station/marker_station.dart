import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';

/// Station Marker Widget
class MarkerStation extends StatelessWidget {
  const MarkerStation(this.color, {super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 11.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white, width: 1.w),
        borderRadius: AppStyle.borderRadius,
        color: color,
      ),
    );
  }
}
