import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/view_model/dark_theme.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeSetting();
}

class _ThemeSetting extends State<ThemeSetting> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DarkTheme>();

    return Padding(
      padding: AppStyle.basicPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('앱 테마 설정', style: Theme.of(context).textTheme.titleMedium),
              Text('라이트, 다크모드를 설정합니다.', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
          SizedBox(
            width: 70.w,
            height: 55.w,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                value: vm.isDark,
                onChanged: (bool isDark) {
                  vm.changeDarkMode(isDark);
                },
                activeTrackColor: AppColor.backgroundBlur(vm.isDark),
                inactiveTrackColor: AppColor.backgroundBlur(vm.isDark),
                thumbColor: MaterialStateProperty.all(AppColor.background(!vm.isDark)),
                trackOutlineColor: MaterialStateProperty.all(AppColor.backgroundBlur(!vm.isDark)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
