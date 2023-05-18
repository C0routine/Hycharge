import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/view/widgets/settings/push_setting.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/view/widgets/settings/app_version.dart';
import 'package:hycharge/view/widgets/settings/theme_setting.dart';
import 'package:hycharge/view_model/dark_theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<DarkTheme>().isDark;

    Divider divider() {
      return Divider(
        height: 0,
        indent: 16.w,
        endIndent: 16.w,
        thickness: 1.h,
        color: AppColor.background(!isDark),
      );
    }

    print('Settings Screen Render');
    return Container(
      margin: EdgeInsets.only(top: AppStyle.safeArea.top),
      child: Column(
        children: [
          const ThemeSetting(),
          divider(),
          const PushSetting(),
          divider(),
          const AppVersion(),
          divider(),
        ],
      ),
    );
  }
}
