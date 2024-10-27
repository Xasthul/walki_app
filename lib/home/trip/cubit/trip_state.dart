part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState({
    this.settings = _defaultTripSettings,
    this.foundPlaces = const FoundPlaces(),
    this.selectedPlaces = const [],
  });

  static const _defaultTripSettings = TripSettings(
    searchRadius: 750,
    travelMode: TripTravelMode.walking,
  );

  final TripSettings settings;
  final FoundPlaces foundPlaces;
  final List<PointOfInterest> selectedPlaces;

  TripState copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
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
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
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
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
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
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
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
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
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
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
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
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
  }) =>
      TripCreationFailed(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}

class TripPlaceSelection extends TripState {
  const TripPlaceSelection({
    super.settings,
    super.foundPlaces,
    super.selectedPlaces,
  });

  @override
  TripPlaceSelection copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    List<PointOfInterest>? selectedPlaces,
  }) =>
      TripPlaceSelection(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        selectedPlaces: selectedPlaces ?? this.selectedPlaces,
      );
}
