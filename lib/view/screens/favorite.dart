import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/favorite_vm.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/navigation_vm.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';
import 'package:hycharge/view_model/station/map_vm.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<StatefulWidget> createState() => FavoriteState();
}

class FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteVM>().updateFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.read<DarkTheme>().isDark;
    final vm = context.watch<FavoriteVM>();
    final mapVM = context.watch<MapVM>();
    final bsVM = context.watch<BottomSheetVM>();
    final naviVM = context.watch<NavigationVM>();

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
    favoriteIcon(String stationId) {
      return Material(
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => vm.removeFavorite(stationId),
          customBorder: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(6.w),
            child: Icon(Icons.favorite, size: 26.w, color: AppColor.enableColor),
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

    print('Favorite Screen Render');
    return Padding(
      padding: EdgeInsets.only(top: AppStyle.safeArea.top),
      child: vm.favoriteList.isNotEmpty
          ? ListView.builder(
              padding: AppStyle.basicPadding,
              itemCount: vm.favoriteList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    naviVM.changeScreen(1);
                    mapVM.markerOnTap(NLatLng(vm.favoriteList[index]!.latitude!, vm.favoriteList[index]!.longitude!), true);
                    bsVM.updateBottomSheet(vm.favoriteList[index]!);
                  },
                  child: Card(
                    margin: index == vm.favoriteList.length - 1 ? EdgeInsets.only(bottom: AppStyle.safeArea.bottom + 60.h) : AppStyle.gapBottom,
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
                                      stationName(vm.favoriteList[index]?.name),
                                      stationAddress(vm.favoriteList[index]?.address, vm.favoriteList[index]?.oldAddress),
                                    ],
                                  ),
                                ),
                              ),
                              favoriteIcon(vm.favoriteList[index]!.stationId!),
                            ],
                          ),
                          Padding(
                            padding: AppStyle.gapTop,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                statusBox('운영상태', vm.getOperateStatus(vm.favoriteList[index])),
                                statusBox('가격/kg', vm.getPrice(vm.favoriteList[index])),
                                statusBox('충전가능', vm.getChargePossible(vm.favoriteList[index])),
                                statusBox('대기차량', vm.getChargeWaiting(vm.favoriteList[index])),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: AppStyle.gapBottom,
                  child: Icon(Icons.favorite_outline_rounded, size: 45.w, color: AppColor.enableColor),
                ),
                Text(
                  '자주 방문하시는 충전소가 없습니다!\n충전소를 추가해주세요~',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
    );
  }
}
