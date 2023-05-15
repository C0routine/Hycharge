import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hycharge/model/services/api.dart';
import 'package:hycharge/model/services/station.dart';
import 'package:hycharge/model/station/station_data.dart';

class BookMarkVM extends ChangeNotifier {
  List<StationData?> _bookMarkList = [];

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

  Future<void> removeBookMark(String stationId) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> bookMarkList = storage.getStringList('bookmark') ?? [];

    if (bookMarkList.isEmpty) return;

    for (int stn = 0; stn < Station.stnList.length; stn++) {
      if (Station.stnList[stn].stationId == stationId) {
        Station.stnList[stn].isBookMark = false;
        break;
      }
    }

    Set<String> newBookMarkList = bookMarkList.toSet();
    newBookMarkList.remove(stationId);
    await storage.setStringList('bookmark', newBookMarkList.toList());

    await updateBookMark();
  }

  // 충전소 정보 update, update 된 data 를 viewModel 동기화
  Future<void> updateBookMark() async {
    bool updateResult = await API.station.updateStationList();

    List<StationData> newBookMarkList = [];
    for (StationData stn in Station.stnList) {
      if (stn.isBookMark) newBookMarkList.add(stn);
    }

    _bookMarkList = newBookMarkList;
    notifyListeners();
  }
}
