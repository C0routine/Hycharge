import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/bookmark_vm.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:provider/provider.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<StatefulWidget> createState() => BookMarkState();
}

class BookMarkState extends State<BookMark> {
  @override
  void initState() {
    super.initState();
    //TODO Storage get
    context.read<BookMarkVM>().updateBookMark();
    print('init BookMark Screen');
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<DarkTheme>().isDark;
    final vm = context.watch<BookMarkVM>();

    /// 충전소 이름
    stationName(String? stationName) {
      return Text(
        stationName ?? '-',
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.clip,
      );
    }

    /// 충전소 주소
    stationAddress(String? address, String? oldAddress) {
      return Text(
        address ?? oldAddress ?? '-',
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.clip,
      );
    }

    /// 충전소 북마크
    bookMarkIcon() {
      return Material(
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {},
          customBorder: const CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.backgroundBlur(isDark),
            ),
            padding: EdgeInsets.all(6.w),
            child: Icon(Icons.bookmark_add_outlined, size: 26.w),
          ),
        ),
      );
    }

    /// 충전소 상태 box
    statusBox(String status, String statusData) {
      return Container(
        width: 75.w,
        height: 75.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: AppColor.enableColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statusData,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.enableColor, fontSize: 14.sp),
            ),
            Text(status, style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      );
    }

    print('BookMark Screen Render');
    return Padding(
      padding: EdgeInsets.only(top: AppStyle.safeArea.top),
      child: ListView.builder(
        padding: AppStyle.basicPadding,
        itemCount: vm.bookMarkList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: AppStyle.gapBottom,
            color: AppColor.backgroundBlur(isDark),
            child: Padding(
              padding: AppStyle.basicPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: AppStyle.gapRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              stationName(vm.bookMarkList[index]?.name),
                              stationAddress(vm.bookMarkList[index]?.address, vm.bookMarkList[index]?.oldAddress),
                            ],
                          ),
                        ),
                      ),
                      bookMarkIcon(),
                    ],
                  ),
                  Padding(
                    padding: AppStyle.gapTop,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statusBox('운영상태', vm.getOperateStatus(vm.bookMarkList[index])),
                        statusBox('가격/kg', vm.getPrice(vm.bookMarkList[index])),
                        statusBox('충전가능', vm.getChargePossible(vm.bookMarkList[index])),
                        statusBox('대기차량', vm.getChargeWaiting(vm.bookMarkList[index])),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
