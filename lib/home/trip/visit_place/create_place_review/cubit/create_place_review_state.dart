part of 'create_place_review_cubit.dart';

sealed class CreatePlaceReviewState extends Equatable {
  const CreatePlaceReviewState();

  @override
  List<Object?> get props => [];
}

class CreatePlaceReviewInitial extends CreatePlaceReviewState {}

class CreatePlaceReviewLoading extends CreatePlaceReviewState {}

class CreatePlaceReviewFailed extends CreatePlaceReviewState {}

class CreatePlaceReviewSuccessful extends CreatePlaceReviewState {}
