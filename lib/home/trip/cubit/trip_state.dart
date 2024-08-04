part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripCurrentLocationLoading extends TripState {}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripPlacesNearbyFound extends TripState {
  const TripPlacesNearbyFound({required this.places});

  final List<LatLng> places;

  @override
  List<Object?> get props => super.props..add(places);
}

class TripCreation extends TripState {
  const TripCreation({
    required this.places,
    required this.selectedPlaces,
  });

  final List<LatLng> places;
  final List<LatLng> selectedPlaces;

  @override
  List<Object?> get props => super.props
    ..addAll([
      places,
      selectedPlaces,
    ]);
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

class TripCreationFailed extends TripState {}
