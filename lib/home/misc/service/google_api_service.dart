import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/home/misc/network/entity/google_api_lat_lng.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/circle_location_restriction.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/location_restriction.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/search_nearby_place_type.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/search_nearby_request.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place.dart';
import 'package:vall/home/misc/network/entity/response/search_nearby_response.dart';

class GoogleApiService {
  GoogleApiService({
    required GoogleApiDioClient client,
  }) : _client = client;

  final GoogleApiDioClient _client;

  Future<List<GoogleApiPlace>> searchPlacesNearby({
    required SearchNearbyPlaceType placeType,
    required int maxResultCount,
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    const url = 'https://places.googleapis.com/v1/places:searchNearby';
    final headers = {'X-Goog-FieldMask': _searchNearbyFieldMask};
    final response = await _client.post(
      url,
      headers: headers,
      body: SearchNearbyRequest(
        includedTypes: [placeType],
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

  String get _searchNearbyFieldMask {
    final List<String> propsWithPrefix = [];
    for (final property in GoogleApiPlace.props) {
      propsWithPrefix.add('places.$property');
    }
    return propsWithPrefix.join(',');
  }
}
