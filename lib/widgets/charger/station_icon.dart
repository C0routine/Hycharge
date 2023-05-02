import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/style/app_colors.dart';

/// MarkerIcon 을 구별하기 위한 값
enum Energy { high, middle, low, zero }

/// Station Marker Widget
class StationIcon extends StatelessWidget {
  const StationIcon({super.key, required this.energy});

  final Energy energy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w,
      height: 9.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white, width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        color: energy == Energy.high
            ? AppColor.blue
            : energy == Energy.middle
                ? AppColor.orange
                : energy == Energy.low
                    ? AppColor.red
                    : AppColor.grey,
      ),
    );
  }
}
