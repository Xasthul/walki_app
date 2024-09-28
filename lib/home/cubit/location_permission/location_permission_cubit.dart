import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'location_permission_state.dart';

class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit() : super(LocationPermissionInitial());

  Future<void> load() async => _checkLocationPermissions();

  Future<void> _checkLocationPermissions() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return emit(LocationPermissionNotProvided());
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(LocationPermissionNotProvided());
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(LocationPermissionNotProvided());
      }

      return emit(LocationPermissionProvided());
    } catch (error) {
      return emit(LocationPermissionNotProvided());
    }
  }
}
