import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view/widgets/station/naver_map_widget.dart';
import 'package:hycharge/view/widgets/station/location_tracking_button.dart';

class StationMap extends StatefulWidget {
  const StationMap({super.key});

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('StationMap Screen Render!');
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const NaverMapWidget(),
          Positioned(
            bottom: AppStyle.safeArea.bottom + 60.w,
            child: const LocationTrackingButton(),
          ),
          // CustomNavigationBar(bottom: 30),
        ],
      ),
    );
  }
}
