import 'package:go_router/go_router.dart';

import 'package:hycharge/view/screens/station/station_map.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StationMap(),
      routes: [],
    ),
  ],
);
