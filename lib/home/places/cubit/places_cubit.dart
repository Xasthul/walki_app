import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/common/entity/trip_step.dart';
import 'package:vall/home/trip/common/use_case/trip_use_case.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit({
    required TripUseCase tripUseCase,
  })  : _tripUseCase = tripUseCase,
        super(PlacesNoTripCreated()) {
    _init();
  }

  final TripUseCase _tripUseCase;
  StreamSubscription<List<TripStep>>? _tripSubscription;

  // TODO(naz): loaded only after tab is opened (should be when home loaded)
  void _init() => _tripSubscription = _tripUseCase.trip.listen((trip) {
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
