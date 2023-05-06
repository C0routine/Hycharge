import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/view_model/app/app_colors.dart';

/// Station Marker Widget
class MarkerRegion extends StatelessWidget {
  const MarkerRegion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.white, width: 1.w),
        color: AppColor.enableColor,
      ),
    );
  }
}
