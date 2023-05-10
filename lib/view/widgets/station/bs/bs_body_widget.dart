import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
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
        margin: EdgeInsets.only(top: bottomVM.getEventNotice() ? 28.h : 0),
        child: bottomVM.getEventNotice()
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('충전소 공지사항', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp)),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundBlur(isDark),
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    child: Text(
                      bottomVM.stationData?.event ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
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
        margin: EdgeInsets.only(top: 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Text('운영시간', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp)),
            ),
            ...List.generate(day.length, (idx) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(color: AppColor.backgroundBlur(isDark), borderRadius: BorderRadius.circular(16.w)),
                child: Row(
                  children: [
                    Text(day[idx], style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700)),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
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
