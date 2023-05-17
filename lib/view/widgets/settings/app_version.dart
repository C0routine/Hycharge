import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/app/app_style.dart';
import 'package:hycharge/view_model/settings_vm.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<StatefulWidget> createState() => _AppVersion();
}

class _AppVersion extends State<AppVersion> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsVM>().getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    final appVersion = context.read<SettingsVM>().appVersion;

    return Padding(
      padding: AppStyle.basicPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('앱 버전', style: Theme.of(context).textTheme.titleMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('현재 앱 버전 : $appVersion', style: Theme.of(context).textTheme.labelMedium),
              Text('최신 앱 버전 : $appVersion', style: Theme.of(context).textTheme.labelMedium),
            ],
          )
        ],
      ),
    );
  }
}
