import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/navigation_vm.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomTabBar();
}

class _CustomTabBar extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NavigationVM>();
    final isDark = context.watch<DarkTheme>().isDark;

    tabAnimatedWidget(int index, IconData iconData) {
      return SizedBox(
        width: (0.7 / 3).sw,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(iconData, color: index == vm.screenIndex ? AppColor.enableColor : AppColor.disableColor),
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.decelerate,
              height: vm.screenIndex == index ? 41.w : 0,
              width: vm.screenIndex == index ? 0.24.sw : 0,
              decoration: BoxDecoration(
                color: vm.screenIndex == index ? AppColor.enableColor.withOpacity(0.25) : Colors.transparent,
                borderRadius: AppStyle.hardBorderRadius,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 55.w,
      margin: EdgeInsets.only(bottom: AppStyle.safeArea.bottom, left: 0.115.sw, right: 0.115.sw),
      padding: EdgeInsets.symmetric(horizontal: 0.035.sw, vertical: 5.w),
      decoration: BoxDecoration(
        color: AppColor.background(isDark),
        borderRadius: AppStyle.hardBorderRadius,
        boxShadow: [BoxShadow(color: AppColor.background(!isDark).withOpacity(0.4), blurRadius: 5)],
      ),
      child: TabBar(
        // isScrollable: true,
        onTap: (int index) => vm.changeScreen(index),
        controller: vm.tabController,
        indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
        indicatorWeight: 0,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(child: tabAnimatedWidget(0, Icons.favorite)),
          Tab(child: tabAnimatedWidget(1, Icons.local_gas_station_rounded)),
          Tab(child: tabAnimatedWidget(2, Icons.settings)),
        ],
      ),
    );
  }
}
