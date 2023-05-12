import 'package:flutter/material.dart';

// App Custom Bottom Navigation 현재 화면 icon 을 표시 하기 위한 index
class NavigationViewModel extends ChangeNotifier {
  int _screenIndex = 1;

  int get screenIndex => _screenIndex;

  /// Screen [index] 0 = BookMark, 1 = Station, 2 = Setting
  void setScreenIndex(int index) {
    _screenIndex = index;
    notifyListeners();
  }
}
