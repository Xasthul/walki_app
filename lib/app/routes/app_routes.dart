import 'package:go_router/go_router.dart';
import 'package:vall/app/common/component/app_bottom_navigation_bar.dart';
import 'package:vall/home/home_page.dart';
import 'package:vall/home/places/places_page.dart';
import 'package:vall/home/trip/trip_page.dart';

final appRoutes = GoRouter(
  initialLocation: PageName.homePagePath,
  routes: [
    GoRoute(
      path: PageName.homePagePath,
      builder: (context, state) => const HomePage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppBottomNavigationBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: PageName.tripPagePath,
            builder: (context, state) => const TripPage(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: PageName.placesPagePath,
            builder: (context, state) => const PlacesPage(),
          ),
        ]),
      ],
    ),
  ],
);

class PageName {
  static const String homePagePath = '/home';
  static const String tripPagePath = '/trip';
  static const String placesPagePath = '/places';
}
