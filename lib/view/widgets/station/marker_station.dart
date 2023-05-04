import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/view_model/app/app_colors.dart';

/// Station Marker Widget
class MarkerStation extends StatelessWidget {
  const MarkerStation(this.color, {super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w,
      height: 9.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white, width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        color: color,
      ),
    );
  }
}
