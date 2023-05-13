import 'package:flutter/material.dart';

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

class _RootScreen extends State<RootScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              BookMark(),
              StationMap(),
              Settings(),
            ],
          ),
          CustomNavigationBar(tabController: tabController),

          // bottomSheet 가 Navigation bar 보다 index 가 우선.
          const StationBottomSheet(),
        ],
      ),
    );
  }
}
