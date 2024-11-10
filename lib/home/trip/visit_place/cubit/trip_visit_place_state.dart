part of 'trip_visit_place_cubit.dart';

sealed class TripVisitPlaceState extends Equatable {
  const TripVisitPlaceState({required this.visitedPlaces});

  final List<PointOfInterest> visitedPlaces;

  @override
  List<Object?> get props => [visitedPlaces];
}

class TripVisitPlaceInitial extends TripVisitPlaceState {
  TripVisitPlaceInitial() : super(visitedPlaces: []);
}

class TripVisitPlaceLoaded extends TripVisitPlaceState {
  const TripVisitPlaceLoaded({required super.visitedPlaces});
}

class TripVisitPlaceReached extends TripVisitPlaceState {
  const TripVisitPlaceReached({
    required this.place,
    required super.visitedPlaces,
  });

  final PointOfInterest place;

  @override
  List<Object?> get props => super.props..add(place);
}

class TripVisitPlaceMarked extends TripVisitPlaceState {
  const TripVisitPlaceMarked({required super.visitedPlaces});
}
