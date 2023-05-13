import 'package:flutter/material.dart';

import 'package:hycharge/model/services/api.dart';
import 'package:hycharge/model/services/station.dart';
import 'package:hycharge/model/station/station_data.dart';

class BookMarkVM extends ChangeNotifier {
  List<StationData> _stationList = [];
  List<StationData?> _bookMarkList = [];

  List<StationData> get stationList => _stationList;

  List<StationData?> get bookMarkList => _bookMarkList;

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
