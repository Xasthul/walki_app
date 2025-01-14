part of 'trip_visit_place_cubit.dart';

sealed class TripVisitPlaceState extends Equatable {
  const TripVisitPlaceState({required this.visitedPlaces});

  final List<VisitedPlace> visitedPlaces;

  @override
  List<Object?> get props => [visitedPlaces];
}

class TripVisitPlaceInitial extends TripVisitPlaceState {
  const TripVisitPlaceInitial({required super.visitedPlaces});
}

class TripVisitPlaceLoaded extends TripVisitPlaceState {
  const TripVisitPlaceLoaded({required super.visitedPlaces});
}

class TripVisitPlaceReached extends TripVisitPlaceState {
  const TripVisitPlaceReached({
    required this.place,
    required super.visitedPlaces,
  });

  final GooglePlace place;

  @override
  List<Object?> get props => super.props..add(place);
}
