import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/view_model/navigation_vm.dart';
import 'package:hycharge/view/screens/bookmark.dart';
import 'package:hycharge/view/screens/settings.dart';
import 'package:hycharge/view/screens/station_map.dart';
import 'package:hycharge/view/widgets/global/custom_navigation_bar.dart';
import 'package:hycharge/view/widgets/station/station_bottom_sheet.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RootScreen();
}

class _RootScreen extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;
    final screenIndex = context.watch<NavigationViewModel>().screenIndex;

    return Scaffold(
      extendBody: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Visibility 를 쓰지 않을 경우 실제 앱이 render 되어 있는 상태로 남아 있음.
          // 상태값은 유지 시키되 render 를 가리기 위해서 Visibility 를 사용.
          Visibility(visible: screenIndex == 0, child: const BookMark()),
          Visibility(visible: screenIndex == 1, maintainState: true, child: StationMap(bottom: bottom)),
          Visibility(visible: screenIndex == 2, child: const Settings()),

          // bottomSheet 가 Navigation bar 보다 index 가 우선.
          CustomNavigationBar(bottom: bottom),
          Visibility(visible: screenIndex == 1, child: StationBottomSheet(bottom: bottom)),
        ],
      ),
    );
  }
}
