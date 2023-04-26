import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/providers/is_dark_mode.dart';
import 'package:hycharge/router.dart';
import 'package:hycharge/style/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  // Widgets 시스템 초기화 확인 & 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // Naver map 초기화
  await NaverMapSdk.instance.initialize(clientId: 'ypvzgk8ero');
  // 가로 모드 제한.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    // Provider 등록
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
  // var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  // bool isDarkMode = brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // 디자인 size width, height
      designSize: const Size(393, 852),
      // width, height 에 따른 font size
      minTextAdapt: true,
      // 분할 화면 지원 여부
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp.router(
          // router setting
          routerConfig: router,

          // light Mode
          theme: context.read<IsDarkMode>().isDarkMode ? AppTheme.dark() : AppTheme.light(),

          // Dark Mode
          // darkTheme: AppTheme.dark(),

          // Debug 모양 가리기
          debugShowCheckedModeBanner: false,

          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        );
      },
    );
  }
}
