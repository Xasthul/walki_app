import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/home/profile/misc/network/response/visited_place_response.dart';

class VisitedPlacesService {
  VisitedPlacesService({
    required AuthorizedDioClient client,
  }) : _client = client;

  final AuthorizedDioClient _client;

  Future<List<VisitedPlaceResponse>> getVisitedPlaces({required String fromDate}) async {
    const url = '${AppConstants.serviceBaseUrl}/visitedPlaces';
    final response = await _client.get(
      url,
      params: {'fromDate': fromDate},
    );
    final items = (response as Map<String, dynamic>)['items'] as List<dynamic>;
    return items.map((item) => VisitedPlaceResponse.fromJson(item as Map<String, dynamic>)).toList();
  }
}
