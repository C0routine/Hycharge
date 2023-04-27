import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/style/app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomNavigationBar();
}

class _CustomNavigationBar extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;
    // final isDark =

    return Container(
      height: 0.15.sw,
      margin: EdgeInsets.only(bottom: bottom, left: 0.12.sw, right: 0.12.sw),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,

        // color: Colors.transparent.withOpacity(0.3),
        // borderRadius: BorderRadius.circular(50.w),
      ),
    );
  }
}
