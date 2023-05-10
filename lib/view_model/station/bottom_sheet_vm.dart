import 'package:flutter/material.dart';
import 'package:hycharge/model/station/station_data.dart';

class BottomSheetVM extends ChangeNotifier {
  final DraggableScrollableController _dragControl = DraggableScrollableController();

  StationData? _stationData;

  bool _bsMode = true;

  bool get bsMode => _bsMode;

  void bsModeChange() {
    _bsMode = !_bsMode;
    notifyListeners();
  }

  DraggableScrollableController get dragController => _dragControl;

  StationData? get stationData => _stationData;

  void updateBottomSheet(StationData stnData) {
    _stationData = stnData;
    openBottomSheet();
    notifyListeners();
  }

  void openBottomSheet() => _dragControl.animateTo(.28, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);

  void closeBottomSheet() => _dragControl.animateTo(0, duration: const Duration(milliseconds: 350), curve: Curves.easeInOutQuart);
}
