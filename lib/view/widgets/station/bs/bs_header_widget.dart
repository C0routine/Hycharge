import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/view_model/app/app_colors.dart';
import 'package:hycharge/view_model/app/dark_theme.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';
import 'package:provider/provider.dart';

class BottomSheetHeaderWidget extends StatefulWidget {
  const BottomSheetHeaderWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheetHeaderWidget();
}

class _BottomSheetHeaderWidget extends State<BottomSheetHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<DarkTheme>().isDark;
    final bottomVM = context.watch<BottomSheetVM>();

    /// 충전소 이름
    stationName() {
      return Text(
        bottomVM.stationData?.name ?? '',
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.clip,
      );
    }

    /// 충전소 주소
    stationAddress() {
      return Text(
        bottomVM.stationData?.address ?? '',
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.clip,
      );
    }

    /// 충전소 북마크
    bookMark() {
      return Material(
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {},
          customBorder: const CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(left: 12.w),
            padding: EdgeInsets.all(6.w),
            child: Icon(Icons.bookmark_add_outlined, size: 26.w),
          ),
        ),
      );
    }

    /// 충전소 상태 box
    statusBox(String status, String statusData) {
      return Expanded(
        flex: 1,
        child: Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3, color: AppColor.enableColor),
            // color: isDark ? ,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statusData,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColor.enableColor,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(status, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      );
    }

    /// 충전소 길찾기
    directions() {
      return Expanded(
        flex: 3,
        child: Container(
          height: 40.h,
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            color: AppColor.enableColor,
            borderRadius: BorderRadius.circular(24.w),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '길 찾기',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.white),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Icon(Icons.map_outlined, color: AppColor.white, size: 26.w),
                )
              ],
            ),
          ),
        ),
      );
    }

    /// 충전소 전화하기
    stationCall() {
      return Expanded(
        flex: 1,
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColor.enableColor,
            borderRadius: BorderRadius.circular(24.w),
          ),
          child: Icon(Icons.phone_in_talk_rounded, color: AppColor.white, size: 26.w),
        ),
      );
    }

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    stationName(),
                    stationAddress(),
                  ],
                ),
              ),
              bookMark(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              children: [
                statusBox('운영여부', 'data'),
                statusBox('가격/kg', 'data'),
                statusBox('충전가능/대', 'data'),
                statusBox('대기차량/대', 'data'),
              ],
            ),
          ),
          Row(
            children: [
              directions(),
              stationCall(),
            ],
          )
        ],
      ),
    );
  }
}
