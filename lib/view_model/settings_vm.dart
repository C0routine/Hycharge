import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsVM extends ChangeNotifier {
  String _appVersion = '1.0.0';

  String get appVersion => _appVersion;

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    notifyListeners();
  }
}
