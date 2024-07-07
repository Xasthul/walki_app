import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:vall/app/common/constants/app_constants.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit({required TripRepository tripRepository})
      : _tripRepository = tripRepository,
        super(TripInitialLocationLoading());

  final TripRepository _tripRepository;
  late LatLng location;

  static const LatLng _defaultLocation = LatLng(54.8986908770719, 23.902795599987545);

  Future<void> init() async => _getInitialLocation();

  Future<void> _getInitialLocation() async {
    location = _defaultLocation;
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      location = LatLng(position.latitude, position.longitude);
    } finally {
      emit(TripInitialLocationLoaded());
    }
  }

  Future<void> createTrip() async {
    emit(TripLoading());
    final List<TripStep> tripSteps = _tripRepository.createTrip(
      startingLatitude: location.latitude,
      startingLongitude: location.longitude,
    );
    final tripStepsNumber = tripSteps.length;
    if (tripStepsNumber < 2) {
      return emit(TripCreationFailed());
    }

    final List<PolylineWayPoint> wayPoints = [];
    if (tripStepsNumber > 2) {
      // NOTE: excluding first and last elements
      for (int i = 1; i < tripStepsNumber - 1; i++) {
        wayPoints.add(PolylineWayPoint(location: '${tripSteps[i].latitude}, ${tripSteps[i].longitude}'));
      }
    }
    final polylinePoints = PolylinePoints();
    final PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(tripSteps.first.latitude, tripSteps.first.longitude),
        destination: PointLatLng(tripSteps.last.latitude, tripSteps.last.longitude),
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
    emit(
      TripCreated(
        polylinePoints: polylineCoordinates,
        tripSteps: tripSteps.map((tripStep) => LatLng(tripStep.latitude, tripStep.longitude)).toList(),
      ),
    );
  }
}
