import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/places/common/repository/places_repository.dart';
import 'package:vall/home/trip/common/entity/point_of_interest.dart';
import 'package:vall/home/trip/common/repository/trip_repository.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit({
    required PlacesRepository placesRepository,
    required TripRepository tripRepository,
  })  : _placesRepository = placesRepository,
        _tripRepository = tripRepository,
        super(PlacesNotDiscovered()) {
    _init();
  }

  final PlacesRepository _placesRepository;
  final TripRepository _tripRepository;
  StreamSubscription<List<PointOfInterest>>? _placesSubscription;

  void _init() => _placesSubscription = _placesRepository.places.listen((places) {
        if (places.isEmpty) {
          return emit(PlacesNotDiscovered());
        }
        emit(PlacesDiscovered(places));
      });

  // TODO(naz): find optimal route method to sort selected places

  void addPlaceToTrip(PointOfInterest place) {
    _tripRepository.addPlace(place);
  }

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    return super.close();
  }
}
