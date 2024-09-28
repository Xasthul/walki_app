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

class TripInitial extends TripState {
  const TripInitial({super.foundPlaces, super.selectedPlaces});
}

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
    super.foundPlaces,
    super.selectedPlaces,
    required this.polylinePoints,
  });

  final List<LatLng> polylinePoints;

  @override
  List<Object?> get props => super.props..add(polylinePoints);
}

class TripCreationFailed extends TripState {
  const TripCreationFailed({super.foundPlaces, super.selectedPlaces});
}
