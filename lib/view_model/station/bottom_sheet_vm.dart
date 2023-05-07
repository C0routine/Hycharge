
import 'package:flutter/cupertino.dart';
import 'package:hycharge/model/station/station_data.dart';

class BottomSheetVM extends ChangeNotifier {
  StationData? _stationData;
  double _bottomSheetInitSize = 0;

  StationData? get stationData => _stationData;
  double get bottomSheetInitSize => _bottomSheetInitSize;

  void updateBottomSheet(StationData stnData) {
    _bottomSheetInitSize = 0.3;
    _stationData = stnData;
    notifyListeners();
  }
}

