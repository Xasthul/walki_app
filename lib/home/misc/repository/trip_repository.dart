import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/misc/entity/place.dart';

class TripRepository {
  final StreamController<List<Place>> _tripController = StreamController.broadcast();

  Stream<List<Place>> get tripStream => _tripController.stream;

  List<Place> _trip = [];

  void togglePlace(Place place) {
    if (_trip.contains(place)) {
      _trip = [..._trip]..remove(place);
    } else {
      _trip = [..._trip, place];
    }
    _tripController.add(_trip);
  }

  void clearTrip() {
    _trip = [];
    _tripController.add(_trip);
  }

  Future<List<LatLng>> getPolylineCoordinates({
    required List<Place> places,
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
        optimizeWaypoints: true,
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
