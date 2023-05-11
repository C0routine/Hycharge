import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';

class BottomSheetBodyWidget extends StatefulWidget {
  const BottomSheetBodyWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheetBodyWidget();
}

class _BottomSheetBodyWidget extends State<BottomSheetBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<DarkTheme>().isDark;
    final bottomVM = context.watch<BottomSheetVM>();

    /// 충전소 공지사항
    eventNotice() {
      return Container(
        margin: EdgeInsets.only(top: bottomVM.getEventNotice() ? 30.h : 0),
        child: bottomVM.getEventNotice()
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('충전소 공지사항', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp)),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: AppStyle.gapTitle,
                    padding: AppStyle.basicPadding,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundBlur(isDark),
                      borderRadius: AppStyle.borderRadius,
                    ),
                    child: Text(bottomVM.stationData?.event ?? '', style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              )
            : null,
      );
    }

    /// 충전소 운영시간
    openDay() {
      final List<String> day = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일', '공휴일'];
      List<String> openDay = bottomVM.getOpenDaySchedule();

      return Container(
        margin: AppStyle.marginTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('운영시간', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp)),
                Text(bottomVM.getBreakTime(), style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            SizedBox(height: 5.h),
            ...List.generate(day.length, (idx) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: AppStyle.basicPadding,
                decoration: BoxDecoration(color: AppColor.backgroundBlur(isDark), borderRadius: AppStyle.borderRadius),
                child: Row(
                  children: [
                    Text(day[idx], style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp)),
                    Padding(
                      padding: AppStyle.gapLeft,
                      child: Text(openDay[idx], style: Theme.of(context).textTheme.bodyMedium!),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eventNotice(),
        openDay(),
      ],
    );
  }
}
