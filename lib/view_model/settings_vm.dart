import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsVM extends ChangeNotifier {
  String _appVersion = '1.0.0';

  bool _notice = true;

  bool get notice => _notice;

  String get appVersion => _appVersion;

  /// App Version get, setting
  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    notifyListeners();
  }

  /// App Push Setting get
  Future<void> getPushSetting() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool? isEnable = storage.getBool('push_notice');

    if (isEnable == false) {
      _notice = false;
      return;
    } else {
      _notice = true;
    }
    notifyListeners();
  }

  /// App Push Notice Topic Setting
  Future<void> setNoticeTopicSetting(bool isEnable) async {
    _notice = isEnable;
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setBool('push_notice', isEnable);

    if (isEnable) {
      await FirebaseMessaging.instance.subscribeToTopic('notice');
      // print('Subscribe notice');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notice');
      // print('Unsubscribe notice');
    }
  }
}
