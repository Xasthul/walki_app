import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/trip/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/misc/entity/trip.dart';

class TripRepository {
  Trip _trip = const Trip(places: []);

  final StreamController<Trip?> _tripController = StreamController.broadcast();

  Stream<Trip?> get tripStream => _tripController.stream;

  void addPlace(PointOfInterest place) {
    if (_trip.places.contains(place)) {
      return;
    }
    _trip = _trip.copyWith(places: [..._trip.places, place]);
    _tripController.add(_trip);
  }

  void clearTrip() {
    _trip = Trip.empty();
    _tripController.add(_trip);
  }

  Future<List<LatLng>> getPolylineCoordinates({
    required List<LatLng> places,
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
