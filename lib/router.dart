import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'package:hycharge/view/screens/root_screen.dart';
import 'package:hycharge/view/screens/splash_screen.dart';

/// GoRouter Page Transition Custom Animation
GoRouterPageBuilder customGoRouterPageBuilder(Widget child) =>
        (context, state) {
      return CustomTransitionPage(
        child: child,
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 1600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.decelerate).animate(animation),
            child: child,
          );
        },
      );
    };

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      pageBuilder: customGoRouterPageBuilder(const SplashScreen()),
    ),
    GoRoute(
      name: 'root',
      path: '/root',
      pageBuilder: customGoRouterPageBuilder(const RootScreen()),
    ),
  ],
);
