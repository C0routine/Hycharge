import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hycharge/app/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/hycharge_app.dart';
import 'package:hycharge/model/services/network.dart';
import 'package:hycharge/model/services/station.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Naver map 초기화
  await NaverMapSdk.instance.initialize(clientId: dotenv.env['NAVER_MAP_CLIENT_ID']);
  // 가로 모드 제한.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Singleton Pattern Network Class Dio 를 초기화
  Network();
  AppTheme();

  // api 중복 호출이 없어야하고, viewModel 간의 data 공유를 하지 않고, Model 에서 Data 를 전역적으로 관리
  // 전역 Data 값을 미리 Load.
  await Station().updateStationList();

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
