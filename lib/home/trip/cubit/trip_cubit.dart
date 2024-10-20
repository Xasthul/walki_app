import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
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
        if (trip.isEmpty) {
          return;
        }
        emit(
          TripCreation(
            foundPlaces: state.foundPlaces,
            selectedPlaces: _tripMapper.mapPointsOfInterestToLatLng(trip),
          ),
        );
      });

  Future<void> findPlaces() async {
    emit(const TripLoading());
    try {
      _tripRepository.clearTrip();
      final currentLocation = await _currentLocationRepository.getCurrentLocation();
      final places = await _placesRepository.findPlaces(startingPosition: currentLocation);
      emit(
        TripPlacesNearbyFound(
          foundPlaces: _tripMapper.mapPointsOfInterestToLatLng(places),
        ),
      );
    } catch (error) {
      // TODO(naz): handle error?
      emit(const TripInitial());
    }
  }

  Future<void> createTrip({required int minutesForTrip}) async {
    if (state.selectedPlaces.isEmpty) {
      return;
    }
    emit(TripLoading.withState(state));
    try {
      final LatLng currentLocation = await _currentLocationRepository.getCurrentLocation();
      final List<LatLng> polylineCoordinates = await _tripRepository.getPolylineCoordinates(
        places: state.selectedPlaces,
        currentLocation: currentLocation,
      );
      emit(
        TripCreated.withState(state, polylinePoints: polylineCoordinates),
      );
    } catch (error) {
      emit(TripCreationFailed.withState(state));
    }
  }

  void clearTrip() {
    emit(TripLoading.withState(state));
    _tripRepository.clearTrip();
    emit(
      TripInitial(foundPlaces: state.foundPlaces),
    );
  }

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
