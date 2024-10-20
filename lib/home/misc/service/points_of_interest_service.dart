import 'package:vall/home/misc/entity/search_nearby_place_type.dart';
import 'package:vall/home/misc/network/dio_client.dart';
import 'package:vall/home/misc/network/entity/google_api_lat_lng.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/circle_location_restriction.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/location_restriction.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/search_nearby_request.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place.dart';
import 'package:vall/home/misc/network/entity/response/search_nearby_response.dart';

class PointsOfInterestService {
  PointsOfInterestService({
    required GoogleApiDioClient client,
  }) : _client = client;

  final GoogleApiDioClient _client;

  Future<List<GoogleApiPlace>> loadPointsOfInterest({
    required int maxResultCount,
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    const baseUrl = 'https://places.googleapis.com/v1/places:searchNearby';
    final headers = {'X-Goog-FieldMask': 'places.displayName,places.location'};
    final response = await _client.post(
      baseUrl,
      headers: headers,
      body: SearchNearbyRequest(
        includedTypes: [SearchNearbyPlaceType.touristAttraction],
        maxResultCount: maxResultCount,
        locationRestriction: LocationRestriction(
          circle: CircleLocationRestriction(
            center: GoogleApiLatLng(latitude: latitude, longitude: longitude),
            radius: radius,
          ),
        ),
      ).toJson(),
    );

    return SearchNearbyResponse.fromJson(response).places;
  }
}
