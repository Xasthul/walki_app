import 'package:flutter/material.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/entity/place_review.dart';
import 'package:vall/home/places/details/misc/component/place_reviews/place_reviews_page.dart';
import 'package:vall/home/places/details/place_details_page.dart';
import 'package:vall/home/profile/misc/widget/settings/profile_settings_page.dart';
import 'package:vall/home/trip/visit_place/create_place_review/create_place_review_page.dart';
import 'package:vall/home/trip/visit_place/misc/widget/trip_visit_place_reached_dialog.dart';

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

  void navigateToPlaceReviews({required List<PlaceReview> reviews}) => _navigationKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => PlaceReviewsPage(reviews: reviews),
        ),
      );

  void showTripVisitPlaceDialog({required GooglePlace place}) => showDialog(
        context: _navigationKey.currentState!.context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) => TripVisitPlaceReachedDialog(place: place),
      );

  void navigateToCreatePlaceReview({required GooglePlace place}) => _navigationKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => CreatePlaceReviewPage(place: place),
        ),
      );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => this != oldWidget;
}
