import 'package:vall/home/misc/entity/place_review.dart';
import 'package:vall/home/misc/network/entity/response/place_review_response.dart';

class PlaceReviewMapper {
  PlaceReview mapPlaceReviewFromResponse(PlaceReviewResponse response) => PlaceReview(
        author: response.author,
        content: response.content,
        createdAt: DateTime.parse(response.createdAt),
      );
}
