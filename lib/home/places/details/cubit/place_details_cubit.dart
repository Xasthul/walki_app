import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/home/misc/entity/place_review.dart';
import 'package:vall/home/misc/repository/place_reviews_repository.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit({
    required String googlePlaceId,
    required PlaceReviewsRepository placeReviewsRepository,
  })  : _googlePlaceId = googlePlaceId,
        _placeReviewsRepository = placeReviewsRepository,
        super(PlaceDetailsInitial());

  final PlaceReviewsRepository _placeReviewsRepository;
  final String _googlePlaceId;

  Future<void> load() async {
    try {
      final reviews = await _placeReviewsRepository.getPlaceReviews(googlePlaceId: _googlePlaceId);
      emit(PlaceDetailsReviewsLoaded(reviews: reviews));
    } catch (error, stackTrace) {
      logger.e('Loading reviews failed', error: error, stackTrace: stackTrace);
      emit(PlaceDetailsLoadingReviewsFailed());
    }
  }
}
