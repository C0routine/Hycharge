import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/view/widgets/global/custom_navigation_bar.dart';
import 'package:hycharge/view/widgets/station/location_tracking_button.dart';
import 'package:hycharge/view/widgets/station/naver_map_widget.dart';
import 'package:hycharge/view/widgets/station/station_bottom_sheet.dart';

class StationMap extends StatefulWidget {
  const StationMap({super.key});

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;

    print('StationMap Screen Render!');
    return Scaffold(
      // extendBody: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const NaverMapWidget(),
          Positioned(
            bottom: (bottom + 60).w,
            child: const LocationTrackingButton(),
          ),
          CustomNavigationBar(bottom: bottom),
          const StationBottomSheet(),
        ],
      ),
    );
  }
}
