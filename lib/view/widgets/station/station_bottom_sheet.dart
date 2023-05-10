import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/view/widgets/station/bs/bs_header_widget.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/view_model/app/app_colors.dart';
import 'package:hycharge/view_model/app/dark_theme.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';

class StationBottomSheet extends StatefulWidget {
  const StationBottomSheet({super.key, required this.bottom});

  final double bottom;

  @override
  State<StatefulWidget> createState() => _StationBottomSheet();
}

class _StationBottomSheet extends State<StationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).viewPadding.top;
    final bool isDark = context.watch<DarkTheme>().isDark;
    final bottomVM = context.watch<BottomSheetVM>();

    AnimatedContainer bsHandlerWidget() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 32.w,
        height: bottomVM.bsMode ? 4.h : 0,
        margin: EdgeInsets.symmetric(vertical: bottomVM.bsMode ? 8.h : 0),
        decoration: BoxDecoration(
          color: AppColor.grey,
          borderRadius: BorderRadius.circular(16.w),
        ),
      );
    }

    print('Render BottomSheet');
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (drag) {
        if (double.parse(drag.extent.toStringAsFixed(5)) >= 0.86999 && bottomVM.bsMode) {
          bottomVM.bsModeChange();
        }

        if (double.parse(drag.extent.toStringAsFixed(5)) <= 0.85999 && bottomVM.bsMode == false) {
          bottomVM.bsModeChange();
        }
        return false;
      },
      child: DraggableScrollableSheet(
        expand: true,
        snap: true,
        snapSizes: const [.28],
        controller: bottomVM.dragController,
        minChildSize: 0,
        maxChildSize: 1,
        initialChildSize: 0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: EdgeInsets.only(bottom: widget.bottom, left: 16.w, right: 16.w),
            decoration: BoxDecoration(
              color: AppColor.background(isDark),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: isDark ? AppColor.blue.withOpacity(0.6) : AppColor.black.withOpacity(0.3),
                  offset: const Offset(0, -1),
                  blurRadius: isDark ? 20 : 3,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 340),
                margin: EdgeInsets.only(top: bottomVM.bsMode ? 0 : top + (Platform.isIOS ? 8.h : 16.h)),
                child: Column(
                  children: [
                    bsHandlerWidget(),
                    BottomSheetHeaderWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
