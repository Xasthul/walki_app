import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
import 'package:vall/home/trip/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/misc/entity/trip.dart';
import 'package:vall/home/trip/misc/repository/trip_repository.dart';
import 'package:vall/home/trip/misc/use_case/current_location_use_case.dart';
import 'package:vall/home/trip/misc/use_case/trip_use_case.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit({
    required TripUseCase tripUseCase,
    required TripRepository tripRepository,
    required PlacesRepository placesRepository,
    required CurrentLocationUseCase currentLocationUseCase,
  })  : _tripUseCase = tripUseCase,
        _tripRepository = tripRepository,
        _placesRepository = placesRepository,
        _currentLocationUseCase = currentLocationUseCase,
        super(TripInitial());

  final TripUseCase _tripUseCase;
  final CurrentLocationUseCase _currentLocationUseCase;
  final TripRepository _tripRepository;
  final PlacesRepository _placesRepository;

  StreamSubscription<Trip?>? _tripSubscription;
  List<PointOfInterest> _places = [];
  Trip? _trip;

  void load() => _setupTripSubscription();

  void _setupTripSubscription() => _tripSubscription = _tripRepository.tripStream.listen((trip) async {
        _trip = trip;
        if (trip == null) {
          return emit(TripCreationFailed());
        }
        emit(
          TripCreation(
            places: _pointsOfInterestToLatLng(_places),
            selectedPlaces: _pointsOfInterestToLatLng(trip.places),
          ),
        );
      });

  Future<void> findPlaces() async {
    emit(TripLoading());
    final currentLocation = await _currentLocationUseCase.getCurrentLocation();
    _places = await _placesRepository.findPlaces(startingPosition: currentLocation);
    emit(
      TripPlacesNearbyFound(
        places: _pointsOfInterestToLatLng(_places),
      ),
    );
  }

  // TODO(naz): show previous state under loading + show previous state when error
  Future<void> createTrip({required int minutesForTrip}) async {
    if (_trip == null || _trip!.places.isEmpty) {
      return;
    }
    emit(TripLoading());
    try {
      final LatLng currentLocation = await _currentLocationUseCase.getCurrentLocation();
      final List<LatLng> polylineCoordinates = await _tripUseCase.getPolylineCoordinates(
        trip: _trip!,
        currentLocation: currentLocation,
      );
      emit(
        TripCreated(
          polylinePoints: polylineCoordinates,
          places: _pointsOfInterestToLatLng(_trip!.places),
        ),
      );
    } catch (error) {
      emit(TripCreationFailed());
    }
  }

  List<LatLng> _pointsOfInterestToLatLng(List<PointOfInterest> places) =>
      places.map((place) => LatLng(place.latitude, place.longitude)).toList();

  void clearTrip() {
    emit(TripLoading());
    _tripRepository.clearTrip();
    emit(TripInitial());
  }

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
