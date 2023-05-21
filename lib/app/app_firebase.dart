import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hycharge/firebase_options.dart';

class AppFirebase {
  static final AppFirebase _appFirebase = AppFirebase._init();

  factory AppFirebase() {
    return _appFirebase;
  }

  AppFirebase._init();

  /// Firebase 초기화, 설정
  Future<void> initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_firebaseMessageForegroundHandler);
  }

  /// Firebase Push Background Listener
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // https://stackoverflow.com/questions/69290074/flutter-firebasemessaging-onbackgroundmessage-never-execute-in-ios
    // backend content_available 값이 있어야 background 실행 가능
    print("Handling a background message: ${message.data}");

    if (message.notification != null) {
      print('notification title : ${message.notification?.title}');
      print('notification body : ${message.notification?.body}');
    }
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  /// Firebase Push Foreground Listener
  void _firebaseMessageForegroundHandler(RemoteMessage message) {
    print('Handling a foreground message: ${message.data}');

    if (message.notification != null) {
      print('notification title : ${message.notification?.title}');
      print('notification body : ${message.notification?.body}');
    }
  }

  /// Get FCM Token
  static Future<String?> getFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcmToken : $fcmToken');
    return fcmToken;
  }

  /// Topic 구독
  static Future<void> topicSubscribeSetting() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool? notice = storage.getBool('push_notice');

    if (notice == false) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notice');
      await storage.setBool('push_notice', false);
      // print('Unsubscribe notice');
      return;
    }

    await FirebaseMessaging.instance.subscribeToTopic('notice');
    await storage.setBool('push_notice', true);
    // print('Subscribe notice');
    return;
  }
}
