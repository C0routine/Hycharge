import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';

class BottomSheetHeaderWidget extends StatefulWidget {
  const BottomSheetHeaderWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheetHeaderWidget();
}

class _BottomSheetHeaderWidget extends State<BottomSheetHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BottomSheetVM>();
    final bool isDark = context.watch<DarkTheme>().isDark;

    /// 충전소 이름
    stationName() {
      return Text(
        vm.stationData?.name ?? '-',
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.clip,
      );
    }

    /// 충전소 주소
    stationAddress() {
      return Text(
        vm.getStationAddress(),
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.clip,
      );
    }

    /// 자주가는 충전소
    favoriteIcon() {
      bool isFavorite = vm.stationData?.isFavorite ?? false;
      return Material(
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {
            if (isFavorite) {
              vm.favoriteRemove();
            } else {
              vm.favoriteAdd();

              const snackBar = SnackBar(
                content: Text('즐겨찾기에 추가 되었습니다.'),
                duration: Duration(milliseconds: 800),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          customBorder: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(6.w),
            child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline_rounded, color: AppColor.enableColor, size: 26.w),
          ),
        ),
      );
    }

    /// 충전소 상태 box
    statusBox(String status, String statusData) {
      return Container(
        width: 80.w,
        height: 80.w,
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

    /// 충전소 길찾기 선택 dialog
    selectDirectionApp() {
      directionApp(String assets, String appName) {
        return GestureDetector(
          onTap: () => vm.directionStation(appName == '티맵'
              ? 'tmap'
              : appName == '네이버맵'
                  ? 'naver'
                  : appName == '카카오맵'
                      ? 'kakao'
                      : 'apple'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: AppStyle.borderRadius,
                child: Image.asset(assets, width: 55.w, height: 55.w),
              ),
              Padding(padding: AppStyle.gapTitle, child: Text(appName, style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        );
      }

      return showDialog(
          context: context,
          builder: (context) {
            final bool isDark = context.watch<DarkTheme>().isDark;
            return Dialog(
              child: Container(
                padding: AppStyle.basicPadding,
                decoration: BoxDecoration(
                  color: AppColor.background(isDark),
                  borderRadius: AppStyle.borderRadius,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '해당 충전소까지\n안내 받을 앱을 선택해주세요.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: AppStyle.gapTop,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          directionApp('assets/icon/tmap_icon.png', '티맵'),
                          directionApp('assets/icon/naver_icon.png', '네이버맵'),
                          directionApp('assets/icon/kakao_icon.png', '카카오맵'),
                          if (Platform.isIOS) directionApp('assets/icon/apple_icon.png', '애플맵'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    /// 충전소 길찾기
    directions() {
      return Expanded(
        flex: 3,
        child: Material(
          color: AppColor.enableColor,
          borderRadius: AppStyle.borderRadius,
          child: InkWell(
            onTap: () => selectDirectionApp(),
            borderRadius: AppStyle.borderRadius,
            child: SizedBox(
              height: 42.h,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('길 찾기', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.white)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Icon(Icons.map_outlined, color: AppColor.white, size: 26.w),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    /// 충전소 전화하기
    stationCall() {
      return Expanded(
        flex: 1,
        child: Material(
          color: AppColor.enableColor,
          borderRadius: AppStyle.borderRadius,
          child: InkWell(
            onTap: () => vm.callLaunch(),
            borderRadius: AppStyle.borderRadius,
            child: SizedBox(
              height: 42.h,
              child: Icon(Icons.phone_in_talk_rounded, color: AppColor.white, size: 26.w),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: AppStyle.gapRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    stationName(),
                    stationAddress(),
                  ],
                ),
              ),
            ),
            favoriteIcon(),
          ],
        ),
        Padding(
          padding: AppStyle.gapVertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              statusBox('운영상태', vm.getOperateStatus()),
              statusBox('가격/kg', vm.getPrice()),
              statusBox('충전가능', vm.getChargePossible()),
              statusBox('대기차량', vm.getChargeWaiting()),
            ],
          ),
        ),
        Row(
          children: [
            directions(),
            SizedBox(height: 42.h, width: 16.h),
            stationCall(),
          ],
        )
      ],
    );
  }
}
