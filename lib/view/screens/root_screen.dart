import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/view/screens/favorite.dart';
import 'package:hycharge/view/screens/settings.dart';
import 'package:hycharge/view/screens/station_map.dart';
import 'package:hycharge/view/widgets/global/custom_navigation_bar.dart';
import 'package:hycharge/view/widgets/station/station_bottom_sheet.dart';
import 'package:hycharge/view_model/navigation_vm.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RootScreen();
}

class _RootScreen extends State<RootScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<NavigationVM>().initTabController(TabController(length: 3, vsync: this, initialIndex: 1));
    super.initState();
  }

  @override
  void dispose() {
    context.read<NavigationVM>().tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabController = context.read<NavigationVM>().tabController;

    print('Root Screen Render');
    return Scaffold(
      // extendBody: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Favorite(),
              StationMap(),
              Settings(),
            ],
          ),
          const CustomNavigationBar(),

          // bottomSheet 가 Navigation bar 보다 index 가 우선.
          const StationBottomSheet(),
        ],
      ),
    );
  }
}
