import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/misc/use_case/current_location_use_case.dart';

part 'initial_location_state.dart';

class InitialLocationCubit extends Cubit<InitialLocationState> {
  InitialLocationCubit({
    required CurrentLocationUseCase currentLocationUseCase,
  })  : _currentLocationUseCase = currentLocationUseCase,
        super(InitialLocationLoading());

  final CurrentLocationUseCase _currentLocationUseCase;

  static const LatLng _defaultLocation = LatLng(54.8986908770719, 23.902795599987545);

  Future<void> load() async {
    try {
      final location = await _currentLocationUseCase.getCurrentLocation();
      emit(InitialLocationLoaded(location: location));
    } catch (error) {
      emit(const InitialLocationLoaded(location: _defaultLocation));
    }
  }
}
