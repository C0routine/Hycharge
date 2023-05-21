import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:hycharge/app/app_colors.dart';
import 'package:hycharge/app/app_firebase.dart';
import 'package:hycharge/app/app_permission.dart';
import 'package:hycharge/model/services/network.dart';
import 'package:hycharge/model/services/station.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    appInitialized();
  }

  /// app 초기화 (Splash Screen Animation 동안 처리)
  Future<void> appInitialized() async {
    // Singleton Pattern Network Class Dio 를 초기화
    Network();

    // api 중복 호출이 없어야하고, viewModel 간의 data 공유를 하지 않고, Model 에서 Data 를 전역적으로 관리
    // 전역 Data 값을 미리 Load.
    await Station().updateStationList();

    // Firebase Push Notification Setting
    if (await AppPermission.getPushPermission()) {
      await AppFirebase.getFcmToken();
      await AppFirebase.topicSubscribeSetting();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Lottie.asset(
              'assets/lottie/splash_screen.json',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
              controller: _controller,
              onLoaded: (LottieComposition composition) {
                _controller
                  ..duration = const Duration(milliseconds: 2000)
                  ..forward().whenComplete(() {
                    context.go('/root');
                  });
              },
            ),
          ),
          const Text(
            'Hy-charge\n하이차지',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColor.white),
          ),
        ],
      ),
    );
  }
}
