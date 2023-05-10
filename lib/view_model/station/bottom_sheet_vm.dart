import 'package:flutter/material.dart';
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

  /// 충전소 전화 걸기
  Future<void> callLaunch() async {
    if (_stationData?.number == null) return;
    if (await canLaunchUrlString('tel:${_stationData!.number}')) {
      await launchUrlString('tel:${_stationData!.number}');
    }
  }

  void bsModeChange() {
    _bsMode = !_bsMode;
    notifyListeners();
  }

  void updateBottomSheet(StationData stnData) {
    _stationData = stnData;
    openBottomSheet();
    notifyListeners();
  }

  void openBottomSheet() => _dragControl.animateTo(.28, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);

  void closeBottomSheet() => _dragControl.animateTo(0, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);
}
