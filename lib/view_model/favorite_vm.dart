import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hycharge/model/services/api.dart';
import 'package:hycharge/model/services/station.dart';
import 'package:hycharge/model/station/station_data.dart';

class FavoriteVM extends ChangeNotifier {
  List<StationData?> _favoriteList = [];

  List<StationData?> get favoriteList => _favoriteList;

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

  // 자주가는 충전소 제거
  Future<void> removeFavorite(String stationId) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> favoriteList = storage.getStringList('favorite') ?? [];

    if (favoriteList.isEmpty) return;

    for (StationData stn in Station.stnList) {
      if (stn.stationId == stationId) {
        stn.isFavorite = false;

        Set<String> newFavoriteList = favoriteList.toSet();
        newFavoriteList.remove(stationId);
        await storage.setStringList('favorite', newFavoriteList.toList());
        await updateFavorite();

        break;
      }
    }
  }

  // 충전소 정보 update, update 된 data 에서 자주가는 충전소 data 필터
  Future<void> updateFavorite() async {
    bool updateResult = await API.station.updateStationList();

    List<StationData> newFavoriteList = [];

    for (StationData stn in Station.stnList) {
      if (stn.isFavorite) newFavoriteList.add(stn);
    }

    final SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> favoriteList = storage.getStringList('favorite') ?? [];

    _favoriteList = newFavoriteList;
    notifyListeners();
  }
}
