import 'package:go_router/go_router.dart';
import 'package:hycharge/screens/charger/charger_find.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => ChargerFind(),
        routes: [

        ],
    ),
  ],
);
