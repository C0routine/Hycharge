import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';
import 'package:hycharge/view/widgets/station/bs/bs_body_widget.dart';
import 'package:hycharge/view/widgets/station/bs/bs_header_widget.dart';

class StationBottomSheet extends StatefulWidget {
  const StationBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _StationBottomSheet();
}

class _StationBottomSheet extends State<StationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).viewPadding.top;
    final bool isDark = context.watch<DarkTheme>().isDark;
    final vm = context.watch<BottomSheetVM>();

    AnimatedContainer bsHandlerWidget() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInQuint,
        width: 32.w,
        height: vm.bsMode ? 4.h : 0,
        margin: EdgeInsets.symmetric(vertical: vm.bsMode ? 8.h : 0),
        decoration: BoxDecoration(
          color: AppColor.backgroundBlur(!isDark),
          borderRadius: AppStyle.borderRadius,
        ),
      );
    }

    print('Render BottomSheet');
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (drag) {
        if (vm.bsMode) {
          if ((drag.extent * 100).floor() >= 91) {
            vm.bsModeChange();
            return true;
          }
          return true;
        }

        if (vm.bsMode == false) {
          if ((drag.extent * 100).floor() <= 85) {
            vm.bsModeChange();
            return true;
          }
          return true;
        }
        return true;
      },
      child: DraggableScrollableSheet(
        snap: true,
        snapSizes: const [.3],
        controller: vm.dragController,
        minChildSize: 0,
        maxChildSize: 1,
        initialChildSize: 0,
        builder: (BuildContext context, ScrollController scrollController) {
          return AnimatedContainer(
            curve: Curves.easeOutCubic,
            duration: const Duration(milliseconds: 400),
            padding: EdgeInsets.only(
              top: vm.bsMode ? 0 : (top + 5.h),
              bottom: AppStyle.safeArea.bottom,
              left: 16.w,
              right: 16.w,
            ),
            decoration: BoxDecoration(
              color: AppColor.background(isDark),
              borderRadius: AppStyle.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: isDark ? AppColor.blue.withOpacity(0.6) : AppColor.black.withOpacity(0.3),
                  offset: const Offset(0, -1),
                  blurRadius: isDark ? 8 : 3,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  bsHandlerWidget(),
                  const BottomSheetHeaderWidget(),
                  const BottomSheetBodyWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
