import 'package:flutter/material.dart';
import 'package:vall/login/create_account/create_account_page.dart';

class LoginNavigator extends InheritedWidget {
  factory LoginNavigator({required Widget child}) {
    final navigationKey = GlobalKey<NavigatorState>();
    return LoginNavigator._(
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

  const LoginNavigator._({
    required super.child,
    required GlobalKey<NavigatorState> navigationKey,
  }) : _navigationKey = navigationKey;

  final GlobalKey<NavigatorState> _navigationKey;

  static LoginNavigator of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<LoginNavigator>()!;

  void pop() => _navigationKey.currentState?.pop();

  void maybePop() => _navigationKey.currentState?.maybePop();

  void popUntilFirst() => _navigationKey.currentState?.popUntil((route) => route.isFirst);

  void navigateToCreateAccount() => _navigationKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => const CreateAccountPage(),
        ),
      );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => this != oldWidget;
}
