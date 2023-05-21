import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:hycharge/hycharge_app.dart';
import 'package:hycharge/app/app_firebase.dart';
import 'package:hycharge/view_model/dark_theme.dart';
import 'package:hycharge/view_model/favorite_vm.dart';
import 'package:hycharge/view_model/settings_vm.dart';
import 'package:hycharge/view_model/navigation_vm.dart';
import 'package:hycharge/view_model/station/map_vm.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';

Future<void> main() async {
  // .env load
  await dotenv.load(fileName: '.env');
  // Widgets 시스템 초기화 확인 & 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase 초기화, 설정
  await AppFirebase().initFirebase();
  // Naver map 초기화 (map widget 실행 전에만 초기화 하면 상관없음)
  await NaverMapSdk.instance.initialize(clientId: dotenv.env['NAVER_MAP_CLIENT_ID']);

  runApp(
    // Provider 등록
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkTheme()),
        ChangeNotifierProvider(create: (_) => NavigationVM()),
        ChangeNotifierProvider(create: (_) => MapVM()),
        ChangeNotifierProvider(create: (_) => BottomSheetVM()),
        ChangeNotifierProvider(create: (_) => FavoriteVM()),
        ChangeNotifierProvider(create: (_) => SettingsVM()),
      ],
      child: const HyChargeApp(),
    ),
  );
}
