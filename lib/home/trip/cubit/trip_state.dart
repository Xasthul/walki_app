part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState({
    this.settings = _defaultTripSettings,
    this.foundPlaces = const [],
    this.selectedPlaces = const [],
  });

  static const _defaultTripSettings = TripSettings(
    searchRadius: 750,
    travelMode: TripTravelMode.walking,
  );

  final TripSettings settings;
  final List<LatLng> foundPlaces;
  final List<LatLng> selectedPlaces;

  TripState copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
  });

  @override
  List<Object?> get props => [
        settings,
        foundPlaces,
        selectedPlaces,
      ];
}

class TripInitial extends TripState {
  const TripInitial({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
  });

  @override
  TripInitial copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
  }) =>
      TripInitial(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}

class TripLoading extends TripState {
  const TripLoading({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
  });

  @override
  TripLoading copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
  }) =>
      TripLoading(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}

class TripPlacesNearbyFound extends TripState {
  const TripPlacesNearbyFound({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
  });

  @override
  TripPlacesNearbyFound copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
  }) =>
      TripPlacesNearbyFound(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}

class TripCreation extends TripState {
  const TripCreation({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
  });

  @override
  TripCreation copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
  }) =>
      TripCreation(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}

class TripCreated extends TripState {
  const TripCreated({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
    required this.polylinePoints,
  });

  final List<LatLng> polylinePoints;

  @override
  TripCreated copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
    List<LatLng>? polylinePoints,
  }) =>
      TripCreated(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
        polylinePoints: polylinePoints ?? this.polylinePoints,
      );

  @override
  List<Object?> get props => super.props..add(polylinePoints);
}

class TripCreationFailed extends TripState {
  const TripCreationFailed({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
  });

  @override
  TripCreationFailed copyWith({
    TripSettings? settings,
    List<LatLng>? foundPlaces,
    List<LatLng>? selectedPlaces,
  }) =>
      TripCreationFailed(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}
