import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:provider/provider.dart';

import 'package:hycharge/hycharge_app.dart';
import 'package:hycharge/providers/dark_theme.dart';

void main() async {
  // .env load
  await dotenv.load(fileName: '.env');
  // Widgets 시스템 초기화 확인 & 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // Naver map 초기화
  await NaverMapSdk.instance.initialize(clientId: dotenv.env['NAVER_MAP_CLIENT_ID']);
  // 가로 모드 제한.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    // Provider 등록
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkTheme()),
      ],
      child: const HyChargeApp(),
    ),
  );
}
