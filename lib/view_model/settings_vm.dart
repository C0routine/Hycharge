import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsVM extends ChangeNotifier {
  String _appVersion = '1.0.0';
  bool _enablePush = true;

  String get appVersion => _appVersion;

  bool get enablePush => _enablePush;

  /// App Version get, setting
  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    notifyListeners();
  }

  /// App PushSetting get, setting
  Future<void> getPushSetting() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool? pushSetting = storage.getBool('notice_push');

    if (pushSetting == null) {
      _enablePush = true;
      return;
    }
    _enablePush = pushSetting;
    notifyListeners();
  }

  Future<void> setPushSetting(bool setting) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool('notice_push', setting);

    //TODO Firebase Messaging Setting

    _enablePush = setting;
    notifyListeners();
  }
}
