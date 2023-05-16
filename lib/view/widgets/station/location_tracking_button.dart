import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/station/map_vm.dart';

/// Location Tracking Button Widget
class LocationTrackingButton extends StatefulWidget {
  const LocationTrackingButton({super.key});

  @override
  State<StatefulWidget> createState() => _LocationTrackingButton();
}

class _LocationTrackingButton extends State<LocationTrackingButton> {
  @override
  Widget build(BuildContext context) {
    final mapVM = context.read<MapVM>();
    final bool isDark = context.watch<DarkTheme>().isDark;

    return Material(
      shape: const CircleBorder(),
      color: AppColor.background(isDark),
      child: InkWell(
        onTap: () => mapVM.setLocationTracking(),
        customBorder: const CircleBorder(),
        splashColor: AppColor.enableColor.withOpacity(0.25),
        highlightColor: AppColor.enableColor.withOpacity(0.25),
        child: SizedBox(
          width: 55.w,
          height: 55.w,
          child: const Icon(Icons.navigation_rounded, color: AppColor.enableColor),
        ),
      ),
    );
  }
}
