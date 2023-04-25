import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hycharge/utils/location_permission.dart';
import 'package:hycharge/utils/open_app_setting.dart';

class ChargerFind extends StatefulWidget {
  const ChargerFind({super.key});

  @override
  State<ChargerFind> createState() => _ChargerFindState();
}

class _ChargerFindState extends State<ChargerFind> {
  @override
  Widget build(BuildContext context) {
    // final locationOverlay = await mapController.getLocationOverlay();
    return Scaffold(
      body: NaverMap(
        options: const NaverMapViewOptions(
          mapType: NMapType.navi,
          nightModeEnable: false,

          minZoom: 6,
          scaleBarEnable: false,
          locationButtonEnable: true,
          // 지도 영역을 한반도 인근으로 제한
          extent: NLatLngBounds(
            southWest: NLatLng(31.43, 122.37),
            northEast: NLatLng(44.35, 132.0),
          ),
        ),
        onMapReady: (controller) async {
          print("네이버 맵 로딩됨!");
          // final location = await controller.getLocationOverlay();
          // print('${location}');
          // controller.setLocationTrackingMode(NLocationTrackingMode.face);
          // final location = controller.getLocationTrackingMode();

          if(await getLocationPermission()) {
            // 권한 승인시
            controller.setLocationTrackingMode(NLocationTrackingMode.follow);

          } else{
            openAppSetting();
            // 권한 거부시 설정 이동 필요
          }
        },

        // onCameraChange: (reason, animated){
        //   print('reason : ${reason.name}');
        // },
      ),
    );


  }
}
