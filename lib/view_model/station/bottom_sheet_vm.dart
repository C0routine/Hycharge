import 'package:flutter/material.dart';
import 'package:hycharge/model/station/station_data.dart';

class BottomSheetVM extends ChangeNotifier {
  final DraggableScrollableController _dragControl = DraggableScrollableController();

  StationData? _stationData;

  DraggableScrollableController get dragController => _dragControl;

  StationData? get stationData => _stationData;

  void updateBottomSheet(StationData stnData) {
    _stationData = stnData;
    openBottomSheet();
    notifyListeners();
  }

  void openBottomSheet() => _dragControl.animateTo(.32, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);

  void closeBottomSheet() => _dragControl.animateTo(0, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);
}
