import 'package:go_router/go_router.dart';

import 'package:hycharge/view/screens/root_screen.dart';
import 'package:hycharge/view/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),

    ),
    GoRoute(
      name: 'root',
      path: '/root',
      builder: (context, state) => const RootScreen(),
    ),
  ],
);
