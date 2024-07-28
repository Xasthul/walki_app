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
        return emit(HomeGetLocationPermissionFailed());
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(HomeGetLocationPermissionFailed());
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(HomeGetLocationPermissionFailed());
      }

      return emit(HomeGetLocationPermissionSuccess());
    } catch (error) {
      return emit(HomeGetLocationPermissionFailed());
    }
  }
}
