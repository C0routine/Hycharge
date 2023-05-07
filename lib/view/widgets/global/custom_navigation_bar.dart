import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/view_model/app/app_colors.dart';
import 'package:hycharge/view_model/app/dark_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.bottom});

  final double bottom;

  @override
  State<StatefulWidget> createState() => _CustomNavigationBar();
}

class _CustomNavigationBar extends State<CustomNavigationBar> {
  int currentIndex = 1;

  final List<IconData> _iconList = [
    Icons.favorite,
    Icons.local_gas_station_rounded,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkTheme>().isDark;

    return Container(
      height: 55.w,
      margin: EdgeInsets.only(bottom: widget.bottom, left: 0.115.sw, right: 0.115.sw),
      padding: EdgeInsets.symmetric(horizontal: 0.035.sw, vertical: 5.w),
      decoration: BoxDecoration(
        color: AppColor.background(isDark),
        borderRadius: BorderRadius.circular(50.w),
      ),
      child: ListView.builder(
        itemCount: _iconList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            // 남은 screen width 0.7, icon 3개만 들어오도록
            width: (0.7 / 3).sw,
            child: InkWell(
              onTap: () {
                if (currentIndex != index) {
                  setState(() {
                    currentIndex = index;
                  });
                }
              },
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(50.w),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _navigationIcon(index, currentIndex == index ? AppColor.enableColor : AppColor.disableColor),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.decelerate,
                    height: index == currentIndex ? 41.w : 0,
                    // 최대 width 로 설정
                    width: index == currentIndex ? 0.24.sw : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex ? AppColor.enableColor.withOpacity(0.25) : Colors.transparent,
                      borderRadius: BorderRadius.circular(50.w),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Icon _navigationIcon(int index, Color color) {
    return Icon(_iconList[index], color: color);
  }
}
