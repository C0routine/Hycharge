import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hycharge/model/services/station.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:hycharge/model/station/station_data.dart';

class BottomSheetVM extends ChangeNotifier {
  final DraggableScrollableController _dragControl = DraggableScrollableController();

  DraggableScrollableController get dragController => _dragControl;

  StationData? _stationData;

  StationData? get stationData => _stationData;

  bool _bsMode = true;

  // bottom Sheet Scroll 변화에 따른 animation flag 값
  bool get bsMode => _bsMode;

  /// 충전소 주소
  String getStationAddress() {
    if (_stationData?.address == null) {
      return _stationData?.oldAddress ?? '-';
    }
    return _stationData!.address!;
  }

  /// 충전소 운영상태
  String getOperateStatus() {
    switch (_stationData?.statusCode) {
      case '10':
        return '영업정지';
      case '20':
        return '영업마감';
      case '30':
        return '운영중';
      default:
        return '-';
    }
  }

  /// 충전소 가격/kg
  String getPrice() {
    if (_stationData?.price == null) return '-';
    return '${_stationData!.price}원';
  }

  /// 충전 가능한 대수
  String getChargePossible() {
    if (_stationData?.possibleVehicle == null) return '-';
    return '${_stationData!.possibleVehicle}대';
  }

  /// 충전 대기중인 대수
  String getChargeWaiting() {
    if (_stationData?.waitingVehicle == null) return '-';
    return '${_stationData!.waitingVehicle}대';
  }

  /// 충전소 길찾기
  Future<void> directionStation(String appName) async {
    /// 충전소 길찾기 url scheme
    Future<void> directionUrlScheme(String url, String ios, String and) async {
      if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
        Platform.isIOS ? await launchUrlString(ios) : await launchUrlString(and);
      }
    }

    if (_stationData?.name != null) {
      final double lat = _stationData!.latitude!;
      final double lng = _stationData!.longitude!;

      // naver map
      final stationName = Uri.encodeComponent(_stationData!.name!);

      final Map<String, Map<String, String>> urlScheme = {
        'naver': {
          'url': 'nmap://navigation?dlat=$lat&dlng=$lng&dname=$stationName&appname=com.hycharge.app',
          'ios': 'http://itunes.apple.com/app/id311867728',
          'and': 'market://details?id=com.nhn.android.nmap',
        },
        'kakao': {
          'url': 'kakaomap://route?ep=$lat,$lng&by=CAR',
          'ios': 'http://itunes.apple.com/app/id304608425',
          'and': 'market://details?id=net.daum.android.map',
        },
        'tmap': {
          'url': 'tmap://open',
          'ios': 'http://itunes.apple.com/app/id431589174',
          'and': 'market://details?id=com.skt.tmap.ku',
        },
      };

      await directionUrlScheme(urlScheme[appName]!['url']!, urlScheme[appName]!['ios']!, urlScheme[appName]!['and']!);
    }
  }

  /// 충전소 전화 걸기
  Future<void> callLaunch() async {
    if (_stationData?.number == null) return;
    if (await canLaunchUrlString('tel:${_stationData!.number}')) {
      await launchUrlString('tel:${_stationData!.number}');
    }
  }

  /// 충전소 공지사항 여부
  bool getEventNotice() {
    if (_stationData?.event == null) return false;
    if (_stationData!.event!.isEmpty) return false;
    return true;
  }

  /// 충전소 휴게시간
  String getBreakTime() {
    if (_stationData?.breakStart == null || _stationData?.breakEnd == null) return '';
    if (_stationData!.breakStart!.isEmpty || _stationData!.breakEnd!.isEmpty) return '';
    return ' (휴게시간 : ${_stationData!.breakStart!} ~ ${_stationData!.breakEnd!})';
  }

  /// 충전소 운영일, 시간
  List<String> getOpenDaySchedule() {
    List<String> schedule = [];
    // if (_stationData == null) return [for (int day = 0; day < 8; day++) '--:-- ~ --:--'];
    if (_stationData?.scheduleDay == null) return [for (int day = 0; day < 8; day++) '--:-- ~ --:--'];

    void checkOpenDay(int idx, String start, String end) {
      // 운영일일 경우
      if (_stationData!.scheduleDay![idx] == '1') {
        return schedule.add('${start.isEmpty ? '--:--' : start} ~ ${end.isEmpty ? '--:--' : end}');
      }
      // 휴무일일 경우
      return schedule.add('휴무');
    }

    for (int idx = 0; idx < _stationData!.scheduleDay!.length; idx++) {
      switch (idx) {
        case 0:
          checkOpenDay(idx, _stationData?.monStart ?? '--:--', _stationData?.monEnd ?? '--:--');
          break;
        case 1:
          checkOpenDay(idx, _stationData?.tueStart ?? '--:--', _stationData?.tueEnd ?? '--:--');
          break;
        case 2:
          checkOpenDay(idx, _stationData?.wedStart ?? '--:--', _stationData?.wedEnd ?? '--:--');
          break;
        case 3:
          checkOpenDay(idx, _stationData?.thurStart ?? '--:--', _stationData?.thurEnd ?? '--:--');
          break;
        case 4:
          checkOpenDay(idx, _stationData?.friStart ?? '--:--', _stationData?.friEnd ?? '--:--');
          break;
        case 5:
          checkOpenDay(idx, _stationData?.satStart ?? '--:--', _stationData?.satEnd ?? '--:--');
          break;
        case 6:
          checkOpenDay(idx, _stationData?.sunStart ?? '--:--', _stationData?.sunEnd ?? '--:--');
          break;
        case 7:
          checkOpenDay(idx, _stationData?.holStart ?? '--:--', _stationData?.holEnd ?? '--:--');
          break;
        default:
          break;
      }
    }

    return schedule;
  }

  /// 자주가는 충전소 제거
  Future<void> favoriteRemove() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> favoriteList = storage.getStringList('favorite') ?? [];

    if (_stationData?.stationId == null) return;

    for (int stn = 0; stn < Station.stnList.length; stn++) {
      if (Station.stnList[stn].stationId == _stationData!.stationId!) {
        Station.stnList[stn].isFavorite = false;

        Set<String> newFavoriteList = favoriteList.toSet();
        newFavoriteList.remove(_stationData!.stationId!);
        await storage.setStringList('favorite', newFavoriteList.toList());
        notifyListeners();

        break;
      }
    }
  }

  /// 자주가는 충전소 추가
  Future<void> favoriteAdd() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> favoriteList = storage.getStringList('favorite') ?? [];

    if (_stationData?.stationId == null) return;

    for (int stn = 0; stn < Station.stnList.length; stn++) {
      if (Station.stnList[stn].stationId == _stationData!.stationId!) {
        Station.stnList[stn].isFavorite = true;

        Set<String> newFavoriteList = favoriteList.toSet();
        newFavoriteList.add(_stationData!.stationId!);
        await storage.setStringList('favorite', newFavoriteList.toList());
        notifyListeners();

        break;
      }
    }
  }

  // Bottom Sheet Mode, Full Mode 전환 (Animation)
  void bsModeChange() {
    _bsMode = !_bsMode;
    notifyListeners();
  }

  /// bottom sheet data 갱신
  void updateBottomSheet(StationData stnData) {
    _stationData = stnData;
    openBottomSheet();
    notifyListeners();
  }

  /// bottom sheet open
  void openBottomSheet() => _dragControl.animateTo(.3, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);

  /// bottom sheet close
  void closeBottomSheet() => _dragControl.animateTo(0, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);
}
