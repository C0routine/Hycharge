import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:hycharge/providers/dark_theme.dart';
import 'package:hycharge/utils/location_permission.dart';
import 'package:hycharge/utils/open_app_setting.dart';

class NaverMapWidget extends StatefulWidget {
  const NaverMapWidget({super.key});

  @override
  State<StatefulWidget> createState() => _NaverMapWidget();
}

class _NaverMapWidget extends State<NaverMapWidget> {
  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        // 지도 유형
        mapType: NMapType.navi,
        // 지도 layer (navi 는 traffic, building 만 지원)
        activeLayerGroups: [NLayerGroup.traffic, NLayerGroup.building],
        // night Mode, navi type 만 지원
        nightModeEnable: context.watch<DarkTheme>().isDark,

        // 최소 zoom
        minZoom: 6,
        // Symbol Scale
        symbolScale: 1.16,
        // 실내 지도 활성화
        indoorEnable: true,
        // 축적 바
        scaleBarEnable: false,
        // naver logo 위치
        logoAlign: NLogoAlign.leftTop,

        // locationButtonEnable: true,

        // 지도 영역을 한반도 인근으로 제한
        extent: const NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: (controller) async {
        print("네이버 맵 로딩됨!");

        final iconImage = await NOverlayImage.fromWidget(
          widget: Icon(Icons.local_gas_station, color: Colors.blue[300], size: 10.w,),
          size: Size(10.w, 10.w),
          context: context,
        );

        final marker = NMarker(id: 'test', position: const NLatLng(37.35959299999998, 127.10531600000002), icon: iconImage);
        controller.addOverlay(marker);

        if (await getLocationPermission()) {
          // 권한 승인시
          controller.setLocationTrackingMode(NLocationTrackingMode.follow);
        } else {
          openAppSetting();
          // 권한 거부시 설정 이동 필요
        }
      },
    );
  }
}
