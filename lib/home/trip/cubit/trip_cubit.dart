import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/places/common/repository/places_repository.dart';
import 'package:vall/home/trip/common/entity/point_of_interest.dart';
import 'package:vall/home/trip/common/entity/trip.dart';
import 'package:vall/home/trip/common/repository/trip_repository.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit({
    required TripRepository tripRepository,
    required PlacesRepository placesRepository,
  })  : _tripRepository = tripRepository,
        _placesRepository = placesRepository,
        super(TripCurrentLocationLoading()) {
    _init();
  }

  // TODO(naz): separate cubit for map and settings?
  // add LocationRepository, which will expose stream of location
  // both cubits listen to them

  final TripRepository _tripRepository;
  final PlacesRepository _placesRepository;

  StreamSubscription<Trip?>? _tripSubscription;
  late LatLng location;
  List<PointOfInterest> _places = [];
  Trip? _trip;

  static const LatLng _defaultLocation = LatLng(54.8986908770719, 23.902795599987545);

  void _init() {
    _setupTripSubscription();
    _getInitialLocation();
  }

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

  Future<void> _getInitialLocation() async {
    location = _defaultLocation;
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      location = LatLng(position.latitude, position.longitude);
    } finally {
      emit(TripInitial());
    }
  }

  Future<void> findPlaces() async {
    emit(TripLoading());
    _places = await _placesRepository.findPlaces(startingPosition: location);
    emit(
      TripPlacesNearbyFound(
        places: _pointsOfInterestToLatLng(_places),
      ),
    );
  }

  Future<void> createTrip({required int minutesForTrip}) async {
    if (_trip == null || _trip!.places.isEmpty) {
      return emit(TripCreationFailed());
    }
    emit(TripLoading());
    try {
      final List<LatLng> polylineCoordinates = await _getPolylineCoordinates(trip: _trip!);
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

  Future<List<LatLng>> _getPolylineCoordinates({required Trip trip}) async {
    final polylinePoints = PolylinePoints();
    final List<PolylineWayPoint> wayPoints = [];
    final places = trip.places;

    final int placesNumber = places.length;
    if (placesNumber > 1) {
      // NOTE: excluding last element - destination
      for (int i = 0; i < placesNumber - 1; i++) {
        wayPoints.add(PolylineWayPoint(location: '${places[i].latitude}, ${places[i].longitude}'));
      }
    }
    final PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(location.latitude, location.longitude),
        destination: PointLatLng(places.last.latitude, places.last.longitude),
        wayPoints: wayPoints,
        mode: TravelMode.walking,
      ),
      googleApiKey: AppConstants.googleApiKey,
    );
    final List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    return polylineCoordinates;
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
