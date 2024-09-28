import 'package:vall/home/trip/misc/entity/point_of_interest.dart';

class PointsOfInterestService {
  // TODO(naz): implement
  Future<List<PointOfInterest>> loadPointsOfInterest({
    required double latitude,
    required double longitude,
  }) async {
    return [
      const PointOfInterest(
        name: 'First',
        latitude: 54.85716665350932,
        longitude: 24.04576358956767,
      ),
      const PointOfInterest(
        name: 'Second',
        latitude: 54.857812930615076,
        longitude: 24.045415145300655,
      ),
      const PointOfInterest(
        name: 'Third',
        latitude: 54.85890489253798,
        longitude: 24.047686485707846,
      ),
    ];
  }
}
