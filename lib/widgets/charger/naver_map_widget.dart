import 'package:flutter/material.dart';
import 'package:hycharge/models/station/hydrogen/station_list.dart';
import 'package:hycharge/service/api.dart';
import 'package:hycharge/widgets/charger/station_icon.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:hycharge/style/app_colors.dart';
import 'package:hycharge/providers/dark_theme.dart';
import 'package:hycharge/utils/location_permission.dart';
import 'package:hycharge/utils/open_app_setting.dart';

class NaverMapWidget extends StatefulWidget {
  // navigation bar padding bottom size
  final double bottom;

  const NaverMapWidget({super.key, required this.bottom});

  @override
  State<StatefulWidget> createState() => _NaverMapWidget();
}

class _NaverMapWidget extends State<NaverMapWidget> {
  late NaverMapController mapController;
  late Map<Energy, NOverlayImage> markerIcon;
  late List<StationList> stationList;

  Future<void> _getStation() async {
    stationList = await API.hydrogenStation.getStationList();

    // 정상적으로 값을 받아왔는지 확인
    if (stationList.isEmpty) return;

    for (StationList station in stationList) {
      int? possibleVehicle = station.possibleVehicle is num ? (station.possibleVehicle! - (station.waitingVehicle ?? 0)) : null;

      final marker = NMarker(
        id: station.stationId!,
        position: NLatLng(station.latitude!, station.longitude!),
        caption: NOverlayCaption(text: '${possibleVehicle ?? '알수없음'}', color: AppColor.skyBlue, haloColor: AppColor.grey),
        captionAligns: [NAlign.center],
        icon: markerIcon[possibleVehicle == null
            ? Energy.zero
            : possibleVehicle == 0
                ? Energy.zero
                : possibleVehicle < 10
                    ? Energy.low
                    : possibleVehicle < 25
                        ? Energy.middle
                        : Energy.high],
      )..setOnTapListener((overlay) => {
            // TODO detail page view
            print(station.name)
          });
      mapController.addOverlay(marker);
    }
  }

  Future<NOverlayImage> _setMarkerIcon(energy) =>
      NOverlayImage.fromWidget(widget: StationIcon(energy: energy), size: Size(15.w, 9.w), context: context);

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
            // NaverMap Controller Backup
            mapController = controller;
            // Marker Icon Load
            markerIcon = {
              Energy.high: await _setMarkerIcon(Energy.high),
              Energy.middle: await _setMarkerIcon(Energy.middle),
              Energy.low: await _setMarkerIcon(Energy.low),
              Energy.zero: await _setMarkerIcon(Energy.zero),
            };

            _setTrackingMode();
            _getStation();
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
