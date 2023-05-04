import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/model/station/region_data.dart';
import 'package:hycharge/model/station/station_data.dart';
import 'package:hycharge/view/widgets/station/marker_station.dart';
import 'package:hycharge/view_model/app/app_colors.dart';
import 'package:hycharge/view_model/app/dark_theme.dart';
import 'package:hycharge/view_model/station/station_map_vm.dart';

class NaverMapWidget extends StatefulWidget {
  // navigation bar padding bottom size
  final double bottom;

  const NaverMapWidget({super.key, required this.bottom});

  @override
  State<StatefulWidget> createState() => _NaverMapWidget();
}

class _NaverMapWidget extends State<NaverMapWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationMapViewModel>();
    final bool isDark = context.watch<DarkTheme>().isDark;

    /// Region Marker Setting
    Future<void> setRegionMarker() async {
      for (RegionData r in viewModel.regionList) {
        NMarker regionMarker = NMarker(
          id: r.fullName,
          position: r.nLatLng,
          caption: NOverlayCaption(text: r.name, color: AppColor.white, haloColor: AppColor.grey),
          captionAligns: [NAlign.center],
          icon: await NOverlayImage.fromWidget(widget: const FlutterLogo(), size: const Size(20, 20), context: context),
        )..setOnTapListener((overlay) => {
              print(r.fullName),
              viewModel.mapController.updateCamera(
                NCameraUpdate.scrollAndZoomTo(
                  target: r.nLatLng,
                  zoom: 7.5,
                )..setAnimation(animation: NCameraAnimation.fly, duration: const Duration(milliseconds: 900)),
              ),
            });

        viewModel.mapController.addOverlay(regionMarker);

        regionMarker
          ..setMaxZoom(7)
          ..setIsMaxZoomInclusive(false);
      }
    }

    /// Station Marker Setting
    Future<void> setStationMarker() async {
      for (StationData stn in viewModel.stationList) {
        int? haveEnergy = stn.possibleVehicle is num ? (stn.possibleVehicle! - (stn.waitingVehicle ?? 0)) : null;

        NMarker stationMarker = NMarker(
          id: stn.stationId!,
          icon: await NOverlayImage.fromWidget(
              widget: MarkerStation(haveEnergy == null
                  ? AppColor.grey
                  : haveEnergy < 10
                      ? AppColor.low
                      : haveEnergy < 25
                          ? AppColor.middle
                          : AppColor.high),
              size: Size(15.w, 9.w),
              context: context),
          position: NLatLng(stn.latitude!, stn.longitude!),
          caption: NOverlayCaption(text: '${haveEnergy ?? '??'}', color: AppColor.white, haloColor: AppColor.grey),
          captionAligns: [NAlign.center],
        )..setOnTapListener((overlay) => {
              print(stn.name),
              viewModel.mapController.updateCamera(
                NCameraUpdate.scrollAndZoomTo(
                  target: NLatLng(stn.latitude!, stn.longitude!),
                  zoom: 14,
                )..setAnimation(animation: NCameraAnimation.fly, duration: const Duration(milliseconds: 900)),
              ),
            });

        viewModel.mapController.addOverlay(stationMarker);

        // addOverlay 하고 설정을 해야 먹힘.
        stationMarker
          ..setMinZoom(7)
          ..setIsMinZoomInclusive(false);
      }
    }

    print('naver map');
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
            await viewModel.initViewModel(controller);
            await viewModel.setLocationTracking();
            await viewModel.updateStation();

            await setRegionMarker();
            await setStationMarker();
            print('Map Ready Complete!');
          },
          onCameraIdle: () {
            // viewModel.updateStation();
          },
        ),
      ],
    );
  }
}
