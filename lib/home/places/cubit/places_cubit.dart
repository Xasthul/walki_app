import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/common/entity/trip.dart';
import 'package:vall/home/trip/common/repository/trip_repository.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit({
    required TripRepository tripRepository,
  })  : _tripRepository = tripRepository,
        super(PlacesNoTripCreated()) {
    _init();
  }

  final TripRepository _tripRepository;
  StreamSubscription<Trip?>? _tripSubscription;

  void _init() => _tripSubscription = _tripRepository.trip.listen((trip) {
        if (trip == null) {
          return emit(PlacesNoTripCreated());
        }
        emit(PlacesTripCreated());
      });

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
