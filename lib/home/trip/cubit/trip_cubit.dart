import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/logger/logger.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
import 'package:vall/home/trip/misc/entity/trip_settings.dart';
import 'package:vall/home/trip/misc/entity/trip_travel_mode.dart';
import 'package:vall/home/trip/misc/mapper/trip_mapper.dart';
import 'package:vall/home/trip/misc/repository/current_location_repository.dart';
import 'package:vall/home/trip/misc/repository/trip_repository.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit({
    required TripRepository tripRepository,
    required PlacesRepository placesRepository,
    required CurrentLocationRepository currentLocationRepository,
    required TripMapper tripMapper,
  })  : _tripRepository = tripRepository,
        _placesRepository = placesRepository,
        _currentLocationRepository = currentLocationRepository,
        _tripMapper = tripMapper,
        super(const TripInitial());

  final CurrentLocationRepository _currentLocationRepository;
  final TripRepository _tripRepository;
  final PlacesRepository _placesRepository;
  final TripMapper _tripMapper;

  StreamSubscription<List<PointOfInterest>>? _tripSubscription;

  void load() => _setupTripSubscription();

  void _setupTripSubscription() => _tripSubscription = _tripRepository.tripStream.listen((trip) {
        if (state is TripLoading) {
          return emit(
            TripLoading(
              settings: state.settings,
              foundPlaces: state.foundPlaces,
              selectedPlaces: _tripMapper.mapPointsOfInterestToLatLng(trip),
            ),
          );
        }
        emit(
          TripCreation(
            settings: state.settings,
            foundPlaces: state.foundPlaces,
            selectedPlaces: _tripMapper.mapPointsOfInterestToLatLng(trip),
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
          foundPlaces: _tripMapper.mapPointsOfInterestToLatLng(places),
        ),
      );
    } catch (error) {
      // TODO(naz): handle error?
      emit(TripInitial(settings: state.settings));
    }
  }

  Future<void> createTrip() async {
    if (state.selectedPlaces.isEmpty) {
      return;
    }
    emit(
      TripLoading(
        settings: state.settings,
        foundPlaces: state.foundPlaces,
        selectedPlaces: state.selectedPlaces,
      ),
    );
    try {
      final LatLng currentLocation = await _currentLocationRepository.getCurrentLocation();
      final List<LatLng> polylineCoordinates = await _tripRepository.getPolylineCoordinates(
        places: state.selectedPlaces,
        currentLocation: currentLocation,
      );
      emit(
        TripCreated(
          settings: state.settings,
          foundPlaces: state.foundPlaces,
          selectedPlaces: state.selectedPlaces,
          polylinePoints: polylineCoordinates,
        ),
      );
    } catch (error, stackTrace) {
      logger.e('Trip creation failed', error: error, stackTrace: stackTrace);
      emit(
        TripCreationFailed(
          settings: state.settings,
          foundPlaces: state.foundPlaces,
          selectedPlaces: state.selectedPlaces,
        ),
      );
    }
  }

  void clearTrip() {
    emit(
      TripLoading(
        settings: state.settings,
        foundPlaces: state.foundPlaces,
        selectedPlaces: state.selectedPlaces,
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

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
