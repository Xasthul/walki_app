import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/misc/repository/current_location_repository.dart';

part 'initial_location_state.dart';

class InitialLocationCubit extends Cubit<InitialLocationState> {
  InitialLocationCubit({
    required CurrentLocationRepository currentLocationRepository,
  })  : _currentLocationRepository = currentLocationRepository,
        super(InitialLocationLoading());

  final CurrentLocationRepository _currentLocationRepository;

  static const LatLng _defaultLocation = LatLng(54.8986908770719, 23.902795599987545);

  Future<void> load() async {
    try {
      final location = await _currentLocationRepository.getCurrentLocation();
      emit(InitialLocationLoaded(location: location));
    } catch (error) {
      emit(const InitialLocationLoaded(location: _defaultLocation));
    }
  }
}
