import 'package:flutter/material.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/places/details/place_details_page.dart';
import 'package:vall/home/profile/misc/widget/settings/profile_settings_page.dart';

class HomeNavigator extends InheritedWidget {
  factory HomeNavigator({
    required GlobalKey<NavigatorState> navigationKey,
    required Widget child,
  }) =>
      HomeNavigator._(
        navigationKey: navigationKey,
        child: NavigatorPopHandler(
          onPop: () => navigationKey.currentState!.maybePop(),
          child: Navigator(
            key: navigationKey,
            onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child),
          ),
        ),
      );

  const HomeNavigator._({
    required super.child,
    required GlobalKey<NavigatorState> navigationKey,
  }) : _navigationKey = navigationKey;

  final GlobalKey<NavigatorState> _navigationKey;

  static HomeNavigator of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<HomeNavigator>()!;

  void pop() => _navigationKey.currentState?.pop();

  void maybePop() => _navigationKey.currentState?.maybePop();

  void popUntilFirst() => _navigationKey.currentState?.popUntil((route) => route.isFirst);

  Future<void> navigateToProfileSettings() => _navigationKey.currentState!.push(
        MaterialPageRoute(builder: (_) => const ProfileSettingsPage()),
      );

  void navigateToPlaceDetails({required GooglePlace place}) => _navigationKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => PlaceDetailsPage(place: place),
        ),
      );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => this != oldWidget;
}
