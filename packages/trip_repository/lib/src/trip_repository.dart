import 'package:point_of_interest_service/point_of_interest_service.dart';
import 'package:trip_repository/src/models/trip_step.dart';

class TripRepository {
  TripRepository({required PointOfInterestService pointOfInterestService})
      : _pointOfInterestService = pointOfInterestService;

  final PointOfInterestService _pointOfInterestService;

  List<TripStep> createTrip({
    required double startingLatitude,
    required double startingLongitude,
  }) {
    final pointsOfInterest = _pointOfInterestService.loadPointsOfInterest(
      latitude: startingLatitude,
      longitude: startingLongitude,
    );
    return [
      TripStep(startingLatitude, startingLongitude),
      ...pointsOfInterest.map((pointsOfInterest) => TripStep(
            pointsOfInterest.latitude,
            pointsOfInterest.longitude,
          )),
    ];
  }
}
