import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hycharge/router.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // Widgets 시스템 초기화 확인 & 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // Naver map 초기화
  await NaverMapSdk.instance.initialize(clientId: 'ypvzgk8ero');
  runApp(
    MaterialApp.router(
      routerConfig: router,
      // Debug 모양 가리기
      debugShowCheckedModeBanner: false,
    ),
  );
}
