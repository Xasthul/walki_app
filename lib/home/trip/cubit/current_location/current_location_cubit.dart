import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit({
    required CurrentLocationRepository currentLocationRepository,
  })  : _currentLocationRepository = currentLocationRepository,
        super(CurrentLocationLoading());

  final CurrentLocationRepository _currentLocationRepository;

  StreamSubscription<LatLng>? _currentLocationSubscription;

  Future<void> load() async => _currentLocationSubscription = _currentLocationRepository.currentLocationStream
      .listen((location) => emit(CurrentLocationUpdated(location: location)));

  @override
  Future<void> close() {
    _currentLocationSubscription?.cancel();
    return super.close();
  }
}
