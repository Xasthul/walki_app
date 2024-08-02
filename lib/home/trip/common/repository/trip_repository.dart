import 'dart:async';
import 'dart:math' show atan2, cos, pi, pow, sin, sqrt;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/common/entity/trip.dart';
import 'package:vall/home/trip/common/service/point_of_interest_service.dart';

class TripRepository {
  TripRepository({required PointOfInterestService pointOfInterestService})
      : _pointOfInterestService = pointOfInterestService;

  final PointOfInterestService _pointOfInterestService;
  static const int _averageWalkingSpeed = 5; // in km/h

  final StreamController<Trip?> _tripController = StreamController.broadcast();

  Stream<Trip?> get trip => _tripController.stream;

  Future<void> createTrip({
    required double startingLatitude,
    required double startingLongitude,
    required int minutesForTrip,
  }) async {
    final pointsOfInterest = await _pointOfInterestService.loadPointsOfInterest(
      latitude: startingLatitude,
      longitude: startingLongitude,
    );

    if (pointsOfInterest.isEmpty) {
      return _tripController.add(null);
    }

    final trip = Trip(
      startingLocation: LatLng(
        startingLatitude,
        startingLongitude,
      ),
      places: pointsOfInterest,
    );

    // TODO(naz): modify trip if not enough time
    final double tripDistance = _calculateTripDistance(trip);
    final double possibleUserDistance = _averageWalkingSpeed * (minutesForTrip / 60);
    if (tripDistance > possibleUserDistance) {
      return _tripController.add(null);
    }
    return _tripController.add(trip);
  }

  double _calculateTripDistance(Trip trip) {
    double tripDistance = 0.0;

    tripDistance += _distanceBetween(
      trip.startingLocation.latitude,
      trip.startingLocation.longitude,
      trip.places[0].latitude,
      trip.places[0].longitude,
    );

    for (int i = 0; i < trip.places.length - 1; i++) {
      tripDistance += _distanceBetween(
        trip.places[i].latitude,
        trip.places[i].longitude,
        trip.places[i + 1].latitude,
        trip.places[i + 1].longitude,
      );
    }
    return tripDistance;
  }

  double _distanceBetween(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // in km
    // assuming earth is a perfect sphere(it's not)

    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) + cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // in km
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180;

  void clearTrip() => _tripController.add(null);
}
