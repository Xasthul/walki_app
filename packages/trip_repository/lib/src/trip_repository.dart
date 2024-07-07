import 'dart:math' show atan2, cos, pi, pow, sin, sqrt;

import 'package:point_of_interest_service/point_of_interest_service.dart';
import 'package:trip_repository/src/models/trip_step.dart';

class TripRepository {
  TripRepository({required PointOfInterestService pointOfInterestService})
      : _pointOfInterestService = pointOfInterestService;

  final PointOfInterestService _pointOfInterestService;
  static const int _averageWalkingSpeed = 5; // in km/h

  List<TripStep> createTrip({
    required double startingLatitude,
    required double startingLongitude,
    required int minutesForTrip,
  }) {
    final pointsOfInterest = _pointOfInterestService.loadPointsOfInterest(
      latitude: startingLatitude,
      longitude: startingLongitude,
    );
    final tripSteps = [
      TripStep(startingLatitude, startingLongitude),
      ...pointsOfInterest.map((pointsOfInterest) => TripStep(
            pointsOfInterest.latitude,
            pointsOfInterest.longitude,
          )),
    ];

    // TODO(naz): modify trip if not enough time
    final double tripDistance = _calculateTripDistance(tripSteps);
    final double possibleUserDistance = _averageWalkingSpeed * (minutesForTrip / 60);
    if (tripDistance > possibleUserDistance) {
      return [];
    }

    return tripSteps;
  }

  double _calculateTripDistance(List<TripStep> tripSteps) {
    double tripDistance = 0.0;
    for (int i = 0; i < tripSteps.length - 1; i++) {
      tripDistance += _distanceBetween(
        tripSteps[i].latitude,
        tripSteps[i].longitude,
        tripSteps[i + 1].latitude,
        tripSteps[i + 1].longitude,
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
}
