import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/view_model/app/app_colors.dart';
import 'package:hycharge/view_model/app/dark_theme.dart';
import 'package:hycharge/view_model/station/station_map_vm.dart';

/// Location Tracking Button Widget
class LocationTrackingButton extends StatefulWidget {
  const LocationTrackingButton({super.key});

  @override
  State<StatefulWidget> createState() => _LocationTrackingButton();
}

class _LocationTrackingButton extends State<LocationTrackingButton> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<DarkTheme>().isDark;
    final viewModel = context.read<StationMapViewModel>();

    return SizedBox(
      width: 55.w,
      height: 55.w,
      child: Material(
        color: AppColor.background(isDark),
        borderRadius: BorderRadius.circular(30).w,
        child: InkWell(
          onTap: () => viewModel.setLocationTracking(),
          splashColor: AppColor.enableColor.withOpacity(0.25),
          highlightColor: AppColor.enableColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(30).w,
          child: Icon(Icons.navigation_rounded, color: AppColor.enableColor),
        ),
      ),
    );
  }
}
