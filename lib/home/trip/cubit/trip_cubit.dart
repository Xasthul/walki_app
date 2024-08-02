import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/trip/common/entity/point_of_interest.dart';
import 'package:vall/home/trip/common/entity/trip.dart';
import 'package:vall/home/trip/common/repository/trip_repository.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit({
    required TripRepository tripRepository,
  })  : _tripRepository = tripRepository,
        super(TripCurrentLocationLoading()) {
    _init();
  }

  final TripRepository _tripRepository;
  StreamSubscription<Trip?>? _tripSubscription;
  late LatLng location;

  static const LatLng _defaultLocation = LatLng(54.8986908770719, 23.902795599987545);

  void _init() {
    _setupTripSubscription();
    _getInitialLocation();
  }

  void _setupTripSubscription() => _tripSubscription = _tripRepository.trip.listen((trip) async {
        if (trip == null) {
          return emit(TripCreationFailed());
        }
        final List<LatLng> polylineCoordinates = await _getPolylineCoordinates(trip: trip);
        final tripSteps = [
          trip.startingLocation,
          ...trip.places.map((PointOfInterest poi) => LatLng(poi.latitude, poi.longitude)),
        ];
        emit(
          TripCreated(
            polylinePoints: polylineCoordinates,
            tripSteps: tripSteps,
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

  Future<void> createTrip({required int minutesForTrip}) async {
    emit(TripLoading());
    try {
      await _tripRepository.createTrip(
        startingLatitude: location.latitude,
        startingLongitude: location.longitude,
        minutesForTrip: minutesForTrip,
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
        origin: PointLatLng(trip.startingLocation.latitude, trip.startingLocation.longitude),
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
