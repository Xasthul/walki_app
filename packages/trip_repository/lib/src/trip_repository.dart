import 'package:point_of_interest_service/point_of_interest_service.dart';

class TripRepository {
  TripRepository({required PointOfInterestService pointOfInterestService})
      : _pointOfInterestService = pointOfInterestService;

  final PointOfInterestService _pointOfInterestService;
}
