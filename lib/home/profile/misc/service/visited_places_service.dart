import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/home/profile/misc/network/response/visited_place_response.dart';

class VisitedPlacesService {
  VisitedPlacesService({
    required AuthorizedDioClient client,
  }) : _client = client;

  final AuthorizedDioClient _client;

  static const _baseUrl = '${AppConstants.serviceBaseUrl}/place-visit-records';

  Future<List<VisitedPlaceResponse>> getVisitedPlaces({required String fromDate}) async {
    final response = await _client.get(
      _baseUrl,
      params: {'fromDate': fromDate},
    );
    final items = (response as Map<String, dynamic>)['items'] as List<dynamic>;
    return items.map((item) => VisitedPlaceResponse.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<void> visitPlace({
    required String googlePlaceId,
    required String name,
    required double latitude,
    required double longitude,
  }) async =>
      _client.post(
        '$_baseUrl/create',
        body: {
          'googlePlaceId': googlePlaceId,
          'name': name,
          'latitude': latitude,
          'longitude': longitude,
        },
      );
}
