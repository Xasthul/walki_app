import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/home/misc/repository/place_reviews_repository.dart';

part 'create_place_review_state.dart';

class CreatePlaceReviewCubit extends Cubit<CreatePlaceReviewState> {
  CreatePlaceReviewCubit({
    required String googlePlaceId,
    required PlaceReviewsRepository placeReviewsRepository,
  })  : _googlePlaceId = googlePlaceId,
        _placeReviewsRepository = placeReviewsRepository,
        super(CreatePlaceReviewInitial());

  final String _googlePlaceId;
  final PlaceReviewsRepository _placeReviewsRepository;

  Future<void> createPlaceReview({required String content}) async {
    try {
      emit(CreatePlaceReviewLoading());
      await _placeReviewsRepository.createPlaceReview(
        googlePlaceId: _googlePlaceId,
        content: content,
      );
      emit(CreatePlaceReviewSuccessful());
    } catch (error, stackTrace) {
      logger.e('Failed to create place review', error: error, stackTrace: stackTrace);
      emit(CreatePlaceReviewFailed());
    }
  }
}
