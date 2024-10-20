import 'package:vall/home/misc/entity/search_nearby_place_type.dart';
import 'package:vall/home/misc/network/dio_client.dart';
import 'package:vall/home/misc/network/request/search_nearby/circle_center_location_restriction.dart';
import 'package:vall/home/misc/network/request/search_nearby/circle_location_restriction.dart';
import 'package:vall/home/misc/network/request/search_nearby/location_restriction.dart';
import 'package:vall/home/misc/network/request/search_nearby/search_nearby_request.dart';
import 'package:vall/home/trip/misc/entity/point_of_interest.dart';

class PointsOfInterestService {
  PointsOfInterestService({
    required GoogleApiDioClient client,
  }) : _client = client;

  final GoogleApiDioClient _client;

  // TODO(naz): implement
  Future<List<PointOfInterest>> loadPointsOfInterest({
    required int maxResultCount,
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    const baseUrl = 'https://places.googleapis.com/v1/places:searchNearby';
    final headers = {'X-Goog-FieldMask': 'places.displayName,places.editorialSummary'};
    final response = await _client.post(
      baseUrl,
      headers: headers,
      body: SearchNearbyRequest(
        includedTypes: [SearchNearbyPlaceType.touristAttraction],
        maxResultCount: maxResultCount,
        locationRestriction: LocationRestriction(
          circle: CircleLocationRestriction(
            center: CircleCenterLocationRestriction(latitude: latitude, longitude: longitude),
            radius: radius,
          ),
        ),
      ).toJson(),
    );

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
