import 'package:vall/home/trip/misc/entity/point_of_interest.dart';

class PointsOfInterestService {
  // TODO(naz): implement
  Future<List<PointOfInterest>> loadPointsOfInterest({
    required double latitude,
    required double longitude,
  }) async {
    return [
      const PointOfInterest(
        name: 'Kaunas Castle',
        latitude: 54.898923599999996,
        longitude: 23.8854063,
      ),
      const PointOfInterest(
        name: 'The Wise Old Man',
        latitude: 54.9003423,
        longitude: 23.8894059,
      ),
      const PointOfInterest(
        name: 'Historical President',
        latitude: 54.8975784,
        longitude: 23.8973102,
      ),
      const PointOfInterest(
        name: 'Museum of the History of Lithuanian Medicine and Pharmacy',
        latitude: 54.897139499999994,
        longitude: 23.8875899,
      ),
    ];
  }
}
