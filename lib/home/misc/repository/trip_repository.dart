import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/misc/entity/trip_places.dart';

class TripRepository {
  final StreamController<TripPlaces> _tripController = StreamController.broadcast();

  Stream<TripPlaces> get tripStream => _tripController.stream;

  TripPlaces _trip = const TripPlaces(
    discoveredPlaces: [],
    customPlaces: [],
  );

  void toggleDiscoveredPlace(PointOfInterest place) {
    if (_trip.discoveredPlaces.contains(place)) {
      _trip = _trip.copyWith(
        discoveredPlaces: [..._trip.discoveredPlaces]..remove(place),
      );
    } else {
      _trip = _trip.copyWith(
        discoveredPlaces: [..._trip.discoveredPlaces, place],
      );
    }
    _tripController.add(_trip);
  }

  void toggleCustomPlace(PointOfInterest place) {
    if (_trip.customPlaces.contains(place)) {
      _trip = _trip.copyWith(
        customPlaces: [..._trip.customPlaces]..remove(place),
      );
    } else {
      _trip = _trip.copyWith(
        customPlaces: [..._trip.customPlaces, place],
      );
    }
    _tripController.add(_trip);
  }

  void clearTrip() {
    _trip = const TripPlaces(
      discoveredPlaces: [],
      customPlaces: [],
    );
    _tripController.add(_trip);
  }

  Future<List<LatLng>> getPolylineCoordinates({
    required List<PointOfInterest> places,
    required LatLng currentLocation,
  }) async {
    final polylinePoints = PolylinePoints();
    final List<PolylineWayPoint> wayPoints = [];

    final int placesNumber = places.length;
    if (placesNumber > 1) {
      // NOTE: excluding last element - destination
      for (int i = 0; i < placesNumber - 1; i++) {
        wayPoints.add(PolylineWayPoint(location: '${places[i].latitude}, ${places[i].longitude}'));
      }
    }
    final PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(currentLocation.latitude, currentLocation.longitude),
        destination: PointLatLng(places.last.latitude, places.last.longitude),
        wayPoints: wayPoints,
        mode: TravelMode.walking,
      ),
      googleApiKey: AppConstants.googleApiKey,
    );
    final List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    return polylineCoordinates;
  }
}
