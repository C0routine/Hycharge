import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/dark_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<StatefulWidget> createState() => _CustomTabBar();
}

class _CustomTabBar extends State<CustomNavigationBar> {
  int focusIndex = 1;

  @override
  void initState() {
    widget.tabController.addListener(() => setState(() => focusIndex = widget.tabController.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkTheme>().isDark;
    final bottom = MediaQuery.of(context).viewPadding.bottom;

    tabAnimatedWidget(int index, IconData iconData) {
      return SizedBox(
        width: (0.7 / 3).sw,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(iconData, color: index == focusIndex ? AppColor.enableColor : AppColor.disableColor),
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.decelerate,
              height: focusIndex == index ? 41.w : 0,
              width: focusIndex == index ? 0.24.sw : 0,
              decoration: BoxDecoration(
                color: focusIndex == index ? AppColor.enableColor.withOpacity(0.25) : Colors.transparent,
                borderRadius: AppStyle.hardBorderRadius,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 55.w,
      margin: EdgeInsets.only(bottom: bottom, left: 0.115.sw, right: 0.115.sw),
      padding: EdgeInsets.symmetric(horizontal: 0.035.sw, vertical: 5.w),
      decoration: BoxDecoration(
        color: AppColor.background(isDark),
        borderRadius: AppStyle.hardBorderRadius,
        boxShadow: [BoxShadow(color: AppColor.background(!isDark).withOpacity(0.4), blurRadius: 5)],
      ),
      child: TabBar(
        // isScrollable: true,
        indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
        controller: widget.tabController,
        labelPadding: const EdgeInsets.all(0),
        tabs: [
          Tab(child: tabAnimatedWidget(0, Icons.favorite)),
          Tab(child: tabAnimatedWidget(1, Icons.local_gas_station_rounded)),
          Tab(child: tabAnimatedWidget(2, Icons.settings)),
        ],
      ),
    );
  }
}
