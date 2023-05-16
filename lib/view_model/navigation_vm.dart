import 'package:flutter/material.dart';

class NavigationVM extends ChangeNotifier {
  int _screenIndex = 1;

  late TabController _tabController;

  // focus 된 screen Index
  int get screenIndex => _screenIndex;

  // tab Controller
  TabController get tabController => _tabController;

  // tab Controller 초기화
  initTabController(TabController controller) => _tabController = controller;

  // focus 된 screen Index 전환
  changeScreen(int index) {
    _screenIndex = index;
    // animateTo Duration 안되는 문제 있음.
    tabController.animateTo(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    notifyListeners();
  }
}
