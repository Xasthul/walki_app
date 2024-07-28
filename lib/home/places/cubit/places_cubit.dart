import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/common/entity/trip_step.dart';
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
  StreamSubscription<List<TripStep>>? _tripSubscription;

  // TODO(naz): loaded only after tab is opened (should be when home loaded)
  void _init() => _tripSubscription = _tripRepository.trip.listen((trip) {
        if (trip.isEmpty) {
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
