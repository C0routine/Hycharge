import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/settings_vm.dart';

class PushSetting extends StatefulWidget {
  const PushSetting({super.key});

  @override
  State<StatefulWidget> createState() => _PushSetting();
}

class _PushSetting extends State<PushSetting> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SettingsVM>().getPushSetting();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SettingsVM>();
    final notice = context.select((SettingsVM value) => value.notice);
    final pushEnable = context.select((SettingsVM value) => value.pushEnable);
    final isDark = context.watch<DarkTheme>().isDark;

    return Padding(
      padding: AppStyle.basicPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('앱 알림 설정', style: Theme.of(context).textTheme.titleMedium),
              Text('알림 수신을 설정합니다.', style: Theme.of(context).textTheme.labelMedium),
              if (!pushEnable) Text('앱 설정에서 알림 권한을 허용해주세요.', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
          SizedBox(
            width: 70.w,
            height: 55.w,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                value: notice,
                onChanged: pushEnable ? (bool enable) => vm.setNoticeTopicSetting(enable) : null,
                activeTrackColor: AppColor.backgroundBlur(isDark),
                inactiveTrackColor: AppColor.backgroundBlur(isDark),
                thumbColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColor.enableColor;
                  }
                  return AppColor.background(!isDark);
                }),
                trackOutlineColor: MaterialStateProperty.all(AppColor.backgroundBlur(!isDark)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
