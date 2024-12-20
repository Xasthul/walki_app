import 'package:vall/home/misc/entity/place_review.dart';
import 'package:vall/home/misc/mapper/place_review_mapper.dart';
import 'package:vall/home/misc/service/place_reviews_service.dart';

class PlaceReviewsRepository {
  PlaceReviewsRepository({
    required PlaceReviewsService placeReviewsService,
    required PlaceReviewMapper placeReviewMapper,
  })  : _placeReviewsService = placeReviewsService,
        _placeReviewMapper = placeReviewMapper;

  final PlaceReviewsService _placeReviewsService;
  final PlaceReviewMapper _placeReviewMapper;

  Future<List<PlaceReview>> getPlaceReviews({required String googlePlaceId}) async {
    final reviews = await _placeReviewsService.getPlaceReviews(googlePlaceId: googlePlaceId);
    return reviews.map(_placeReviewMapper.mapPlaceReviewFromResponse).toList();
  }

  Future<void> createPlaceReview({
    required String googlePlaceId,
    required String content,
  }) async =>
      _placeReviewsService.createPlaceReviews(
        googlePlaceId: googlePlaceId,
        content: content,
      );
}
