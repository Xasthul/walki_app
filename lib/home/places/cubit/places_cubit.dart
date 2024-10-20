import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
import 'package:vall/home/trip/misc/repository/trip_repository.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit({
    required PlacesRepository placesRepository,
    required TripRepository tripRepository,
  })  : _placesRepository = placesRepository,
        _tripRepository = tripRepository,
        super(PlacesNotDiscovered());

  final PlacesRepository _placesRepository;
  final TripRepository _tripRepository;
  StreamSubscription<List<PointOfInterest>>? _placesSubscription;

  void load() => _placesSubscription = _placesRepository.places.listen((places) {
        if (places.isEmpty) {
          return emit(PlacesNotDiscovered());
        }
        emit(PlacesDiscovered(places));
      });

  // TODO(naz): find optimal route method to sort selected places

  void addPlaceToTrip(PointOfInterest place) => _tripRepository.togglePlace(place);

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    return super.close();
  }
}
