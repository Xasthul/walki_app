import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
import 'package:vall/home/trip/misc/entity/trip.dart';
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
        super(TripInitial());

  final CurrentLocationRepository _currentLocationRepository;
  final TripRepository _tripRepository;
  final PlacesRepository _placesRepository;
  final TripMapper _tripMapper;

  StreamSubscription<Trip?>? _tripSubscription;

  void load() => _setupTripSubscription();

  void _setupTripSubscription() => _tripSubscription = _tripRepository.tripStream.listen((trip) async {
        if (trip == null) {
          return emit(TripCreationFailed(foundPlaces: state.foundPlaces));
        }
        emit(
          TripCreation(
            foundPlaces: state.foundPlaces,
            selectedPlaces: _tripMapper.mapPointsOfInterestToLatLng(trip.places),
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
      emit(TripInitial());
    }
  }

  Future<void> createTrip({required int minutesForTrip}) async {
    if (state.selectedPlaces.isEmpty) {
      return;
    }
    emit(TripLoading(
      foundPlaces: state.foundPlaces,
      selectedPlaces: state.selectedPlaces,
    ));
    try {
      final LatLng currentLocation = await _currentLocationRepository.getCurrentLocation();
      final List<LatLng> polylineCoordinates = await _tripRepository.getPolylineCoordinates(
        places: state.selectedPlaces,
        currentLocation: currentLocation,
      );
      emit(
        TripCreated(
          polylinePoints: polylineCoordinates,
          places: state.selectedPlaces,
        ),
      );
    } catch (error) {
      emit(TripCreationFailed(
        foundPlaces: state.foundPlaces,
        selectedPlaces: state.selectedPlaces,
      ));
    }
  }

  void clearTrip() {
    emit(TripLoading(
      foundPlaces: state.foundPlaces,
      selectedPlaces: state.selectedPlaces,
    ));
    _tripRepository.clearTrip();
  }

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
