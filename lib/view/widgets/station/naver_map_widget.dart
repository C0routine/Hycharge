import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/model/station/region_data.dart';
import 'package:hycharge/model/station/station_data.dart';
import 'package:hycharge/view/widgets/station/marker_region.dart';
import 'package:hycharge/view/widgets/station/marker_station.dart';
import 'package:hycharge/view_model/app/app_colors.dart';
import 'package:hycharge/view_model/app/dark_theme.dart';
import 'package:hycharge/view_model/station/map_vm.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';

class NaverMapWidget extends StatefulWidget {
  const NaverMapWidget({super.key});

  @override
  State<StatefulWidget> createState() => _NaverMapWidget();
}

class _NaverMapWidget extends State<NaverMapWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<DarkTheme>().isDark;
    final mapVM = context.read<MapVM>();
    final bottomSheetVM = context.read<BottomSheetVM>();

    /// Region Marker Setting
    Future<void> setRegionMarker() async {
      final markerIcon = await NOverlayImage.fromWidget(widget: const MarkerRegion(), size: Size(18.w, 18.w), context: context);

      for (RegionData r in mapVM.regionList) {
        NMarker regionMarker = NMarker(
            id: r.fullName,
            position: r.nLatLng,
            caption: NOverlayCaption(text: r.name, color: AppColor.white, haloColor: AppColor.grey),
            subCaption: NOverlayCaption(
                text: r.totalPrice != 0 ? (r.totalPrice ~/ r.priceFew).toString() : '0', color: AppColor.white, haloColor: AppColor.grey),
            captionAligns: [NAlign.center],
            icon: markerIcon)
          ..setOnTapListener((overlay) => {
                print(r.fullName),
                mapVM.mapController.updateCamera(
                  NCameraUpdate.scrollAndZoomTo(
                    target: r.nLatLng,
                    zoom: 7.5,
                  )..setAnimation(animation: NCameraAnimation.fly, duration: const Duration(milliseconds: 700)),
                ),
              });

        mapVM.mapController.addOverlay(regionMarker);

        // location overlay 와 zindex 가 겹쳐 click 안되기에 최상단으로 지정
        regionMarker
          ..setGlobalZIndex(500000)
          ..setMaxZoom(7)
          ..setIsMaxZoomInclusive(false);
      }
    }

    /// Station Marker Setting
    Future<void> setStationMarker() async {
      // MarkerStation load 함으로써 resource 최적화 (0.3초 단축 성공)
      final energy = {
        'high': await NOverlayImage.fromWidget(widget: const MarkerStation(AppColor.high), size: Size(15.w, 9.w), context: context),
        'middle': await NOverlayImage.fromWidget(widget: const MarkerStation(AppColor.middle), size: Size(15.w, 9.w), context: context),
        'low': await NOverlayImage.fromWidget(widget: const MarkerStation(AppColor.low), size: Size(15.w, 9.w), context: context),
        'empty': await NOverlayImage.fromWidget(widget: const MarkerStation(AppColor.grey), size: Size(15.w, 9.w), context: context),
      };

      for (StationData stn in mapVM.stationList) {
        int? haveEnergy = stn.possibleVehicle is num ? (stn.possibleVehicle! - (stn.waitingVehicle ?? 0)) : null;

        NMarker stationMarker = NMarker(
          id: stn.stationId!,
          icon: (haveEnergy == null || haveEnergy == 0)
              ? energy['empty']
              : haveEnergy < 10
                  ? energy['low']
                  : haveEnergy < 25
                      ? energy['middle']
                      : energy['high'],
          position: NLatLng(stn.latitude!, stn.longitude!),
          caption: NOverlayCaption(text: '${stn.possibleVehicle ?? '??'}', color: AppColor.white, haloColor: AppColor.grey),
          captionAligns: [NAlign.center],
        )..setOnTapListener((overlay) => {
              print(stn.timeStamp),
              bottomSheetVM.updateBottomSheet(stn),
              mapVM.mapController.updateCamera(
                NCameraUpdate.scrollAndZoomTo(
                  target: NLatLng(stn.latitude!, stn.longitude!),
                  zoom: 14,
                )..setAnimation(animation: NCameraAnimation.fly, duration: const Duration(milliseconds: 700)),
              ),
            });

        mapVM.mapController.addOverlay(stationMarker);

        // addOverlay 하고 설정을 해야 먹힘.
        stationMarker
          ..setGlobalZIndex(500000)
          ..setMinZoom(7)
          ..setIsMinZoomInclusive(false);
      }
    }

    print('Naver Map Render');
    return NaverMap(
      options: NaverMapViewOptions(
        // 지도 유형
        mapType: NMapType.navi,
        // 지도 layer (navi 는 traffic, building 만 지원)
        activeLayerGroups: [NLayerGroup.traffic, NLayerGroup.building],
        // night Mode, navi type 만 지원
        nightModeEnable: isDark,
        // Camera 위치 초기 설정 (서울특별시 시청)
        initialCameraPosition: const NCameraPosition(target: NLatLng(37.5666102, 126.9783881), zoom: 16),

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
        await mapVM.initViewModel(controller);
        await mapVM.setLocationTracking();
        await mapVM.updateStation();

        await setRegionMarker();
        await setStationMarker();
        mapVM.setMapReady(true);
      },
      onCameraIdle: () async {
        // camera change event end, Get station data
        if (mapVM.mapReady) {
          if (await mapVM.updateStation()) {
            await setStationMarker();
            await setRegionMarker();
          }
        }
      },
    );
  }
}
