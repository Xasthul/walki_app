part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState({
    this.settings = _defaultTripSettings,
    this.foundPlaces = const FoundPlaces(
      places: [],
      restaurants: [],
      cafes: [],
    ),
    this.tripPlaces = const TripPlaces(
      discoveredPlaces: [],
      customPlaces: [],
    ),
  });

  static const _defaultTripSettings = TripSettings(
    searchRadius: 750,
    travelMode: TripTravelMode.walking,
  );

  final TripSettings settings;
  final FoundPlaces foundPlaces;
  final TripPlaces tripPlaces;

  TripState copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  });

  @override
  List<Object?> get props => [
        settings,
        foundPlaces,
        tripPlaces,
      ];
}

class TripInitial extends TripState {
  const TripInitial({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
  });

  @override
  TripInitial copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  }) =>
      TripInitial(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
      );
}

class TripLoading extends TripState {
  const TripLoading({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
  });

  @override
  TripLoading copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  }) =>
      TripLoading(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
      );
}

class TripPlacesNearbyFound extends TripState {
  const TripPlacesNearbyFound({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
  });

  @override
  TripPlacesNearbyFound copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  }) =>
      TripPlacesNearbyFound(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
      );
}

class TripCreation extends TripState {
  const TripCreation({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
  });

  @override
  TripCreation copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  }) =>
      TripCreation(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
      );
}

class TripCreated extends TripState {
  const TripCreated({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
    required this.polylinePoints,
  });

  final List<LatLng> polylinePoints;

  @override
  TripCreated copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
    List<LatLng>? polylinePoints,
  }) =>
      TripCreated(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
        polylinePoints: polylinePoints ?? this.polylinePoints,
      );

  @override
  List<Object?> get props => super.props..add(polylinePoints);
}

class TripCreationFailed extends TripState {
  const TripCreationFailed({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
  });

  @override
  TripCreationFailed copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  }) =>
      TripCreationFailed(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
      );
}

class TripPlaceSelection extends TripState {
  const TripPlaceSelection({
    super.settings,
    super.foundPlaces,
    super.tripPlaces,
  });

  @override
  TripPlaceSelection copyWith({
    TripSettings? settings,
    FoundPlaces? foundPlaces,
    TripPlaces? tripPlaces,
  }) =>
      TripPlaceSelection(
        settings: settings ?? this.settings,
        foundPlaces: foundPlaces ?? this.foundPlaces,
        tripPlaces: tripPlaces ?? this.tripPlaces,
      );
}
