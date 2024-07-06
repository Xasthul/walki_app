import 'package:go_router/go_router.dart';
import 'package:vall/home/home_page.dart';

const String _initialPagePath = '/';

final appRoutes = GoRouter(
  initialLocation: _initialPagePath,
  routes: [
    GoRoute(
      path: _initialPagePath,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
