import 'package:go_router/go_router.dart';

import 'package:hycharge/view/screens/bookmark.dart';
import 'package:hycharge/view/screens/station_map.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StationMap(),
      routes: [
        GoRoute(path: 'bookmark', builder: (context, state) => const BookMark(), routes: const []),
      ],
    ),
  ],
);
