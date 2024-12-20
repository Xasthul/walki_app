part of 'place_details_cubit.dart';

sealed class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();

  @override
  List<Object?> get props => [];
}

class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsReviewsLoaded extends PlaceDetailsState {
  const PlaceDetailsReviewsLoaded({required this.reviews});

  final List<PlaceReview> reviews;

  @override
  List<Object?> get props => super.props..add(reviews);
}

class PlaceDetailsLoadingReviewsFailed extends PlaceDetailsState {}
