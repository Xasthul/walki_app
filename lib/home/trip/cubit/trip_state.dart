part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState({
    this.foundPlaces = const [],
    this.selectedPlaces = const [],
  });

  final List<LatLng> foundPlaces;
  final List<LatLng> selectedPlaces;

  @override
  List<Object?> get props => [foundPlaces, selectedPlaces];
}

class TripInitial extends TripState {}

class TripLoading extends TripState {
  const TripLoading({super.foundPlaces, super.selectedPlaces});
}

class TripPlacesNearbyFound extends TripState {
  const TripPlacesNearbyFound({super.foundPlaces});
}

class TripCreation extends TripState {
  const TripCreation({super.foundPlaces, super.selectedPlaces});
}

class TripCreated extends TripState {
  const TripCreated({
    required this.polylinePoints,
    required this.places,
  });

  final List<LatLng> polylinePoints;
  final List<LatLng> places;

  @override
  List<Object?> get props => super.props
    ..addAll([
      polylinePoints,
      places,
    ]);
}

class TripCreationFailed extends TripState {
  const TripCreationFailed({super.foundPlaces, super.selectedPlaces});
}
