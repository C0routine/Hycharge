import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hycharge/app/app_style.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/router.dart';
import 'package:hycharge/app/app_theme.dart';
import 'package:hycharge/view_model/dark_theme.dart';

class HyChargeApp extends StatefulWidget {
  const HyChargeApp({super.key});

  @override
  State<StatefulWidget> createState() => _HyChargeApp();
}

class _HyChargeApp extends State<HyChargeApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // 3.7.10 deprecated WidgetsBinding.instance.window
    // use PlatformDispatcher or View.of(context)
    // System Dark & Light Mode Change Listener
    final instance = PlatformDispatcher.instance;

    instance.onPlatformBrightnessChanged = () {
      // TODO Remove print comments
      print('Current Theme : ${instance.platformBrightness == Brightness.dark ? 'Dark' : 'Light'}');
      context.read<DarkTheme>().changeDarkMode(instance.platformBrightness == Brightness.dark);
    };
  }

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
          // Performance Overlay
          // showPerformanceOverlay: true,

          // router setting
          routerConfig: router,

          // App Theme
          theme: context.watch<DarkTheme>().isDark ? AppTheme.dark() : AppTheme.light(),
          // theme: AppTheme.light(),
          // darkTheme: AppTheme.dark(),
          // themeMode: Provider.of<DarkTheme>(context).getTheme,

          // Debug 모양 가리기
          debugShowCheckedModeBanner: false,

          builder: (context, child) {
            AppStyle.safeArea = MediaQuery.of(context).viewPadding;
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
