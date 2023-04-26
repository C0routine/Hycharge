import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hycharge/providers/is_dark_mode.dart';
import 'package:hycharge/router.dart';
import 'package:hycharge/style/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  // Widgets 시스템 초기화 확인 & 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // Naver map 초기화
  await NaverMapSdk.instance.initialize(clientId: 'ypvzgk8ero');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IsDarkMode()),
      ],
      child: const HyChargeApp(),
    ),
  );
}

class HyChargeApp extends StatelessWidget {
  const HyChargeApp({super.key});

  // var brightness = SchedulerBinding.instance.window.platformBrightness;
  // bool isDarkMode = brightness == Brightness.dark;
  // or (as suggested by Moore's Lawyer)
  //
  // var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  // bool isDarkMode = brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    // bool dark = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    // () => context.watch<IsDarkMode>().changeMode(dark);


    return MaterialApp.router(
      // router setting
      routerConfig: router,

      // light Mode
      theme: context.read<IsDarkMode>().isDarkMode ? AppTheme.dark() : AppTheme.light(),

      // Dark Mode
      // darkTheme: AppTheme.dark(),

      // Debug 모양 가리기
      debugShowCheckedModeBanner: false,
    );
  }
}
