import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/home/misc/entity/found_places.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';
import 'package:vall/home/misc/repository/places_repository.dart';
import 'package:vall/home/misc/repository/trip_repository.dart';
import 'package:vall/home/trip/misc/entity/trip_places.dart';
import 'package:vall/home/trip/misc/entity/trip_settings.dart';
import 'package:vall/home/trip/misc/entity/trip_travel_mode.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit({
    required TripRepository tripRepository,
    required PlacesRepository placesRepository,
    required CurrentLocationRepository currentLocationRepository,
  })  : _tripRepository = tripRepository,
        _placesRepository = placesRepository,
        _currentLocationRepository = currentLocationRepository,
        super(const TripInitial());

  final CurrentLocationRepository _currentLocationRepository;
  final TripRepository _tripRepository;
  final PlacesRepository _placesRepository;

  StreamSubscription<TripPlaces>? _tripSubscription;

  void load() => _setupTripSubscription();

  void _setupTripSubscription() => _tripSubscription = _tripRepository.tripStream.listen((trip) {
        // NOTE: needed for loading to be shown when find places
        if (state is TripLoading) {
          return emit(
            TripLoading(
              settings: state.settings,
              foundPlaces: state.foundPlaces,
              tripPlaces: trip,
            ),
          );
        }
        emit(
          TripCreation(
            settings: state.settings,
            foundPlaces: state.foundPlaces,
            tripPlaces: trip,
          ),
        );
      });

  Future<void> findPlaces() async {
    emit(TripLoading(settings: state.settings));
    try {
      _tripRepository.clearTrip();
      final currentLocation = await _currentLocationRepository.getCurrentLocation();
      final places = await _placesRepository.findPlaces(
        startingPosition: currentLocation,
        radius: state.settings.searchRadius,
      );
      emit(
        TripPlacesNearbyFound(
          settings: state.settings,
          foundPlaces: FoundPlaces(
            places: places,
            restaurants: const [],
            cafes: const [],
          ),
        ),
      );
    } catch (error) {
      // TODO(naz): handle error?
      emit(TripInitial(settings: state.settings));
    }
  }

  Future<void> createTrip() async {
    if (state.tripPlaces.isEmpty) {
      return;
    }
    emit(
      TripLoading(
        settings: state.settings,
        foundPlaces: state.foundPlaces,
        tripPlaces: state.tripPlaces,
      ),
    );
    try {
      final LatLng currentLocation = await _currentLocationRepository.getCurrentLocation();
      final List<LatLng> polylineCoordinates = await _tripRepository.getPolylineCoordinates(
        places: [...state.tripPlaces.discoveredPlaces, ...state.tripPlaces.customPlaces],
        currentLocation: currentLocation,
      );
      emit(
        TripCreated(
          settings: state.settings,
          foundPlaces: state.foundPlaces,
          tripPlaces: state.tripPlaces,
          polylinePoints: polylineCoordinates,
        ),
      );
    } catch (error, stackTrace) {
      logger.e('Trip creation failed', error: error, stackTrace: stackTrace);
      emit(
        TripCreationFailed(
          settings: state.settings,
          foundPlaces: state.foundPlaces,
          tripPlaces: state.tripPlaces,
        ),
      );
    }
  }

  void clearTrip() {
    emit(
      TripLoading(
        settings: state.settings,
        foundPlaces: state.foundPlaces,
        tripPlaces: state.tripPlaces,
      ),
    );
    _tripRepository.clearTrip();
    emit(
      TripInitial(
        settings: state.settings,
        foundPlaces: state.foundPlaces,
      ),
    );
  }

  void updateSearchRadius(double newRadius) => emit(
        state.copyWith(
          settings: TripSettings(
            searchRadius: newRadius,
            travelMode: state.settings.travelMode,
          ),
        ),
      );

  void updateTravelMode(TripTravelMode travelMode) => emit(
        state.copyWith(
          settings: TripSettings(
            travelMode: travelMode,
            searchRadius: state.settings.searchRadius,
          ),
        ),
      );

  void startPlaceSelection() => emit(
        TripPlaceSelection(
          settings: state.settings,
          tripPlaces: state.tripPlaces,
          foundPlaces: state.foundPlaces,
        ),
      );

  void closePlaceSelection() => emit(
        TripCreation(
          settings: state.settings,
          tripPlaces: state.tripPlaces,
          foundPlaces: state.foundPlaces,
        ),
      );

  void selectPlace(LatLng place) => _tripRepository.toggleCustomPlace(
        PointOfInterest(
          // TODO(naz): localized, numbered?
          name: 'Your place #${state.tripPlaces.customPlaces.length + 1}',
          latitude: place.latitude,
          longitude: place.longitude,
          photoUrl: '',
        ),
      );

  Future<void> findRestaurants() async {
    _emitLoadingWithCurrentState();
    try {
      final currentLocation = await _currentLocationRepository.getCurrentLocation();
      final restaurants = await _placesRepository.findRestaurants(
        startingPosition: currentLocation,
        radius: state.settings.searchRadius,
      );
      emit(
        TripCreation(
          settings: state.settings,
          foundPlaces: FoundPlaces(
            places: state.foundPlaces.places,
            restaurants: restaurants,
            cafes: state.foundPlaces.cafes,
          ),
          tripPlaces: state.tripPlaces,
        ),
      );
    } catch (error) {
      // TODO(naz): handle error?
      _emitInitialWithCurrentState();
    }
  }

  Future<void> findCafes() async {
    _emitLoadingWithCurrentState();
    try {
      final currentLocation = await _currentLocationRepository.getCurrentLocation();
      final cafes = await _placesRepository.findCafes(
        startingPosition: currentLocation,
        radius: state.settings.searchRadius,
      );
      emit(
        TripCreation(
          settings: state.settings,
          foundPlaces: FoundPlaces(
            places: state.foundPlaces.places,
            restaurants: state.foundPlaces.restaurants,
            cafes: cafes,
          ),
          tripPlaces: state.tripPlaces,
        ),
      );
    } catch (error) {
      // TODO(naz): handle error?
      _emitInitialWithCurrentState();
    }
  }

  void _emitInitialWithCurrentState() => emit(
        TripInitial(
          settings: state.settings,
          foundPlaces: state.foundPlaces,
          tripPlaces: state.tripPlaces,
        ),
      );

  void _emitLoadingWithCurrentState() => emit(
        TripLoading(
          foundPlaces: state.foundPlaces,
          tripPlaces: state.tripPlaces,
          settings: state.settings,
        ),
      );

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
