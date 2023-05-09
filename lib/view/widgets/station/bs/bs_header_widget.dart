import 'package:flutter/cupertino.dart';
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
    // final bool isDark = context.watch<DarkTheme>().isDark;
    final bottomVM = context.watch<BottomSheetVM>();

    Row stationName() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'ashecficifnosfchoicfhamopi3hcfpw3hcowhcgowimchgawo3cgho',
              // bottomVM.stationData?.name ?? '',
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.clip,
            ),
          ),
          Container(
            width: 40.w,
            height: 40.w,
            child: Material(
              color: Colors.green,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.bookmark_add_outlined,
                  size: 20.w,
                ),
              ),
            ),
          )
        ],
      );
    }

    Text stationAddress() {
      return Text(
        bottomVM.stationData?.address ?? '',
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    Row tagBox() {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(6.w),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
            margin: EdgeInsets.only(bottom: 10.h, right: 10.w, top: 10.h),
            child: Text(
              '09시~18시 운영',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(6.w),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
            margin: EdgeInsets.only(bottom: 10.h, right: 10.w, top: 10.h),
            child: Text(
              '${bottomVM.stationData?.price.toString()}원' ?? '알수없음',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(6.w),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
            margin: EdgeInsets.only(bottom: 10.h, right: 10.w, top: 10.h),
            child: Text(
              '승용/버스',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),Container(
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(6.w),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
            margin: EdgeInsets.only(bottom: 10.h, right: 10.w, top: 10.h),
            child: Text(
              '충전압력 700bar',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      );
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stationName(),
          stationAddress(),
          tagBox(),
        ],
      ),
    );
  }
}
