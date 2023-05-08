import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hycharge/model/services/api.dart';
import 'package:hycharge/model/station/region_data.dart';
import 'package:hycharge/model/station/station_data.dart';
import 'package:hycharge/view_model/app/app_permission.dart';

/// NaverMap ViewModel (NaverMapViewModel 초기화 필수)
class MapVM extends ChangeNotifier {
  late NaverMapController _mapController;
  late NLocationOverlay _locationOverlay;
  List<StationData> _stationList = [];
  List<RegionData> _regionList = [];

  // request delay time
  int _delayTimeStamp = 0;

  // map Ready
  bool _mapReady = false;

  NaverMapController get mapController => _mapController;

  NLocationOverlay get locationOverlay => _locationOverlay;

  List<StationData> get stationList => _stationList;

  List<RegionData> get regionList => _regionList;

  int get delayTimeStamp => _delayTimeStamp;

  bool get mapReady => _mapReady;

  setMapReady(bool ready) => _mapReady = ready;

  /// NaverMapViewModel 초기화, NaverMap-onMapReady 실행 이후에 사용.
  Future<void> initViewModel(NaverMapController controller) async {
    _mapController = controller;
    _locationOverlay = await controller.getLocationOverlay();
  }

  /// 실시간 위치 추적 (Smooth Animation Apply)
  Future<void> setLocationTracking() async {
    // 권한 승인시
    if (await AppPermission.getLocationPermission()) {
      // 실시간 locationOverlay 위치 값 가져오기
      _locationOverlay = await _mapController.getLocationOverlay();
      NLatLng location = await _locationOverlay.getPosition();

      // 실시간 위치 활성화 상태인지 확인
      if (location.latitude != 0.0 || location.longitude != 0.0) {
        NCameraPosition camera = await _mapController.getCameraPosition();

        // 실시간 위치 좌표로 Camera Animation 이동
        await _mapController.updateCamera(
          NCameraUpdate.scrollAndZoomTo(
            zoom: camera.zoom < 16 ? 16 : camera.zoom,
            target: NLatLng(location.latitude, location.longitude),
          )..setAnimation(animation: NCameraAnimation.fly, duration: const Duration(milliseconds: 900)),
        );
      }

      // 실시간 위치 활성화 (await 하지 말것, 다음 작업 안됨)
      _mapController.setLocationTrackingMode(NLocationTrackingMode.follow);
    } else {
      // TODO 설정 이동 안내 필요
      // 권한 거부시 설정 이동
      await openAppSettings();
    }
  }

  /// 충전소 정보 update
  Future<bool> updateStation() async {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    if (_delayTimeStamp >= currentTimeStamp) {
      print('Request Delay... have time : ${(_delayTimeStamp - currentTimeStamp) / 1000}sec');
      return false;
    }

    // update station 값을 받아오고 빈 값인지 확인
    List<StationData> stations = await API.station.getStationList();
    if (stations.isEmpty) return false;

    // 최초 1회만 할당하기 위해x, region 값이 빈값인지 확인.
    // if (regionList.isEmpty) {
    //   List<RegionData> regions = stationRegionFilter(stations);
    //   _regionList = regions;
    // }

    // region 값이 빈값인지 확인. (평균 가격 변화)
    List<RegionData> regions = stationRegionFilter(stations);
    _regionList = regions;

    // 성공적으로 update 된 station 값으로 변경.
    _stationList = stations;

    // request delay setting
    // _delayTimeStamp = DateTime.now().millisecondsSinceEpoch + 180000;
    _delayTimeStamp = DateTime.now().millisecondsSinceEpoch + 30000;
    return true;
    // notifyListeners();
  }
}
