import 'package:go_router/go_router.dart';
import 'package:vall/app/common/component/app_bottom_navigation_bar.dart';
import 'package:vall/home/home_page.dart';
import 'package:vall/home/places/places_page.dart';
import 'package:vall/home/trip/trip_page.dart';

const String _homePagePath = '/home';
const String _tripPagePath = 'trip';
const String _placesPagePath = 'places';

final appRoutes = GoRouter(
  initialLocation: _homePagePath,
  routes: [
    GoRoute(
      path: _homePagePath,
      builder: (context, state) => const HomePage(),
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => AppBottomNavigationBar(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: _tripPagePath,
                builder: (context, state) => const TripPage(),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: _placesPagePath,
                builder: (context, state) => const PlacesPage(),
              ),
            ]),
          ],
        ),
      ],
    ),
  ],
);
