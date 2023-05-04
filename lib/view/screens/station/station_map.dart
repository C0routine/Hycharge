import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/view/widgets/global/custom_navigation_bar.dart';
import 'package:hycharge/view/widgets/station/location_tracking_button.dart';
import 'package:hycharge/view/widgets/station/naver_map_widget.dart';

class StationMap extends StatefulWidget {
  const StationMap({super.key});

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          NaverMapWidget(bottom: bottom),
          Positioned(
            bottom: (bottom + 60).w,
            child: const LocationTrackingButton(),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
