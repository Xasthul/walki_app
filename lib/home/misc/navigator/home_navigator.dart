import 'package:flutter/material.dart';
import 'package:vall/home/profile/misc/widget/settings/profile_settings_page.dart';

class HomeNavigator extends InheritedWidget {
  factory HomeNavigator({required Widget child}) {
    final navigationKey = GlobalKey<NavigatorState>();
    return HomeNavigator._(
      navigationKey: navigationKey,
      child: NavigatorPopHandler(
        onPop: () => navigationKey.currentState!.maybePop(),
        child: Navigator(
          key: navigationKey,
          onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child),
        ),
      ),
    );
  }

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

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => this != oldWidget;
}
