import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/home/misc/network/entity/response/place_review_response.dart';

class PlaceReviewsService {
  PlaceReviewsService({
    required AuthorizedDioClient client,
  }) : _client = client;

  final AuthorizedDioClient _client;

  static const _baseUrl = '${AppConstants.serviceBaseUrl}/place-reviews';

  Future<List<PlaceReviewResponse>> getPlaceReviews({required String googlePlaceId}) async {
    final response = await _client.get('$_baseUrl/$googlePlaceId');
    final items = (response as Map<String, dynamic>)['items'] as List<dynamic>;
    return items.map((item) => PlaceReviewResponse.fromJson(item as Map<String, dynamic>)).toList();
  }
}
