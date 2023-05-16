import 'package:go_router/go_router.dart';

import 'package:hycharge/view/screens/root_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const RootScreen()),
  ],
);
