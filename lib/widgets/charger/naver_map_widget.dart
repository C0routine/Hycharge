import 'package:flutter/material.dart';
import 'package:hycharge/service/api.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:hycharge/style/app_colors.dart';
import 'package:hycharge/providers/dark_theme.dart';
import 'package:hycharge/utils/location_permission.dart';
import 'package:hycharge/utils/open_app_setting.dart';
import 'package:hycharge/models/station/hydrogen/station_list.dart';

class NaverMapWidget extends StatefulWidget {
  // navigation bar padding bottom size
  final double bottom;

  const NaverMapWidget({super.key, required this.bottom});

  @override
  State<StatefulWidget> createState() => _NaverMapWidget();
}

class _NaverMapWidget extends State<NaverMapWidget> {
  late NaverMapController mapController;

  Future<void> _getStation() async {
    final List<HydrogenStationList> stationList = await API.hydrogenStation.getStationList();

    // 정상적으로 값을 받아왔는지 확인
    if (stationList.isEmpty) return;

    // TODO 추후 API 서버 개설시 충전소 상태별 icon 분리 필요
    // final iconImage = await NOverlayImage.fromWidget(
    //   widget: Icon(
    //     Icons.local_gas_station,
    //     color: Colors.blue[300],
    //     size: 10.w,
    //   ),
    //   size: Size(10.w, 10.w),
    //   context: context,
    // );

    for (HydrogenStationList station in stationList) {
      // TODO 현재 Server data 신뢰할 수 없으므로 한번 더 확인, 추후 서버 개설하면 수정 필요
      if ((station.chrstnMno?.isNotEmpty ?? false) && (station.let?.isNotEmpty ?? false) && (station.lon?.isNotEmpty ?? false)) {
        final marker = NMarker(id: station.chrstnMno!, position: NLatLng(double.parse(station.let!), double.parse(station.lon!)))
          ..setOnTapListener((overlay) => {
                // TODO detail page view & detail api calls
                print(station.chrstnNm)
              });
        mapController.addOverlay(marker);
      }
    }
  }

  Future<void> _setTrackingMode() async {
    if (await getLocationPermission()) {
      // 권한 승인시
      await mapController.setLocationTrackingMode(NLocationTrackingMode.follow);
    } else {
      // 권한 거부시 설정 이동 필요
      openAppSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.read<DarkTheme>().isDark;

    print('rerender');
    return Stack(
      alignment: Alignment.center,
      children: [
        NaverMap(
          options: NaverMapViewOptions(
            // 지도 유형
            mapType: NMapType.navi,
            // 지도 layer (navi 는 traffic, building 만 지원)
            activeLayerGroups: [NLayerGroup.traffic, NLayerGroup.building],
            // night Mode, navi type 만 지원
            nightModeEnable: isDark,

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

            // 지도 영역을 한반도 인근으로 제한
            extent: const NLatLngBounds(
              southWest: NLatLng(31.43, 122.37),
              northEast: NLatLng(44.35, 132.0),
            ),
          ),
          onMapReady: (controller) async {
            print("Naver Map Loading!");
            mapController = controller;

            _setTrackingMode();
            // _getStation();
          },
        ),
        Positioned(
          bottom: (widget.bottom + 60).w,
          child: SizedBox(
            width: 55.w,
            height: 55.w,
            child: Material(
              color: AppColor.background(isDark),
              borderRadius: BorderRadius.circular(30).w,
              child: InkWell(
                // onTap: () => _setTrackingMode(),
                onTap: () => _getStation(),
                splashColor: AppColor.enableColor.withOpacity(0.25),
                highlightColor: AppColor.enableColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(30).w,
                child: Icon(Icons.navigation_rounded, color: AppColor.enableColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
