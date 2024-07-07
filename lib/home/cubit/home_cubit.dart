import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialLocationLoading());

  static const LatLng _defaultLocation = LatLng(54.8986908770719, 23.902795599987545);

  Future<void> init() async {
    await _checkLocationPermissions();
    await _getInitialLocation();
  }

  Future<void> _checkLocationPermissions() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return emit(GetLocationPermissionFailed());
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(GetLocationPermissionFailed());
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(GetLocationPermissionFailed());
      }
    } catch (error) {
      return emit(GetLocationPermissionFailed());
    }
  }

  Future<void> _getInitialLocation() async {
    LatLng initialLocation = _defaultLocation;
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      initialLocation = LatLng(position.latitude, position.longitude);
    } finally {
      emit(InitialLocationLoaded(initialLocation));
    }
  }
}
