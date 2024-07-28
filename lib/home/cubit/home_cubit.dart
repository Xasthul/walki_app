import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _checkLocationPermissions();
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

      return emit(GetLocationPermissionSuccess());
    } catch (error) {
      return emit(GetLocationPermissionFailed());
    }
  }
}
