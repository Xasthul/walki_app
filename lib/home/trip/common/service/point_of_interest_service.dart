import 'package:vall/home/trip/common/entity/point_of_interest.dart';

class PointOfInterestService {
  // TODO(naz): implement
  List<PointOfInterest> loadPointsOfInterest({
    required double latitude,
    required double longitude,
  }) {
    return [
      PointOfInterest(54.85716665350932, 24.04576358956767),
      PointOfInterest(54.857812930615076, 24.045415145300655),
      PointOfInterest(54.85890489253798, 24.047686485707846),
    ];
  }
}
