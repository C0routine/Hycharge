import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final bool isDark = context.watch<DarkTheme>().isDark;
    final bottomVM = context.watch<BottomSheetVM>();

    Container _itemWidget(double height, double top) {
      return Container(
        width: 100,
        height: height,
        color: AppColor.red,
        margin: EdgeInsets.only(top: top),
      );
    }

    Column _columnWidget() {
      return Column(
        children: [
          Container(
            width: 60,
            height: 5,
            color: AppColor.grey,
          ),
          _itemWidget(100, 0),
          _itemWidget(200, 50),
          _itemWidget(300, 50),
          _itemWidget(400, 50),
          _itemWidget(500, 50),
        ],
      );
    }

    // Container _

    // bottomVM.dragController.addListener(() { })

    print('Render BottomSheet');
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (drag) {
        print(drag.extent);
        if (double.parse(drag.extent.toStringAsFixed(5)) >= 0.95999 && bottomVM.bsMode) {
          bottomVM.bsModeChange();
        }

        if (double.parse(drag.extent.toStringAsFixed(5)) <= 0.80999 && bottomVM.bsMode == false) {
          bottomVM.bsModeChange();
        }

        // if ((double.parse(drag.extent.toStringAsFixed(5)) == 0.31999 || double.parse(drag.extent.toStringAsFixed(5)) == 0.32000) &&
        //     (bottomVM.bsMode == false)) {
        //   bottomVM.bsModeChange();
        // }
        return false;
      },
      child: DraggableScrollableSheet(
        expand: true,
        snap: true,
        snapSizes: const [.32],
        controller: bottomVM.dragController,
        minChildSize: 0,
        maxChildSize: 1,
        initialChildSize: 0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
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
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w, bottom: widget.bottom),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              // child: SafeArea(top: !bottomVM.bsMode, child: _columnWidget()),
              child: AnimatedContainer(
                margin: EdgeInsets.only(top: bottomVM.bsMode ? 0 :60),
                duration: Duration(milliseconds: 700),
                child: _columnWidget(),
              ),
            ),
            // ),
          );
        },
      ),
    );
  }
}
