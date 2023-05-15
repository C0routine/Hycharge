import 'package:flutter/material.dart';

import 'package:hycharge/model/services/api.dart';
import 'package:hycharge/model/services/station.dart';
import 'package:hycharge/model/station/station_data.dart';

class BookMarkVM extends ChangeNotifier {
  List<StationData> _stationList = [];
  List<StationData?> _bookMarkList = [];

  List<StationData> get stationList => _stationList;

  List<StationData?> get bookMarkList => _bookMarkList;

  /// 충전소 운영상태
  String getOperateStatus(StationData? stationData) {
    switch (stationData?.statusCode) {
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
  String getPrice(StationData? stationData) {
    if (stationData?.price == null) return '-';
    return '${stationData!.price}원';
  }

  /// 충전 가능한 대수
  String getChargePossible(StationData? stationData) {
    if (stationData?.possibleVehicle == null) return '-';
    return '${stationData!.possibleVehicle}대';
  }

  /// 충전 대기중인 대수
  String getChargeWaiting(StationData? stationData) {
    if (stationData?.waitingVehicle == null) return '-';
    return '${stationData!.waitingVehicle}대';
  }

  // 충전소 list 에서 bookmark 정보 get
  void findBookMark() {
    //TODO storage load bookmark
    //TODO stationList filter Bookmark

    //TODO bookmark Data load.
    _bookMarkList = _stationList;
  }

  // 충전소 정보 update, update 된 data 를 viewModel 동기화
  Future<void> updateBookMark() async {
    bool updateResult = await API.station.updateStationList();

    _stationList = Station.stnList;
    findBookMark();
    notifyListeners();
  }
}
