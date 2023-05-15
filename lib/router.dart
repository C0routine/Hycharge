import 'package:go_router/go_router.dart';

import 'package:hycharge/view/screens/root_screen.dart';
import 'package:hycharge/view/screens/favorite.dart';
import 'package:hycharge/view/screens/settings.dart';
import 'package:hycharge/view/screens/station_map.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const RootScreen()),
    // GoRoute(path: '/station', builder: (context, state) => const StationMap(bottom: 30)),
    // GoRoute(path: '/bookmark', builder: (context, state) => const BookMark()),
    // GoRoute(path: '/settings', builder: (context, state) => const Settings()),
  ],
);
