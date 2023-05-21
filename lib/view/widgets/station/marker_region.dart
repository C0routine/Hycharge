import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/app/app_colors.dart';

/// Station Marker Widget
class MarkerRegion extends StatelessWidget {
  const MarkerRegion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.white, width: 1.w),
        color: AppColor.enableColor,
      ),
    );
  }
}
