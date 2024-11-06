import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/misc/entity/found_places.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/repository/places_repository.dart';
import 'package:vall/home/misc/repository/trip_repository.dart';

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
  StreamSubscription<List<PointOfInterest>>? _restaurantsSubscription;
  StreamSubscription<List<PointOfInterest>>? _cafesSubscription;
  StreamSubscription<List<PointOfInterest>>? _tripSubscription;

  void load() {
    _setupPlacesSubscription();
    _setupTripSubscription();
    _setupRestaurantsSubscription();
    _setupCafesSubscription();
  }

  void _setupPlacesSubscription() => _placesSubscription = _placesRepository.placesStream.listen((places) {
        if (places.isEmpty) {
          return emit(PlacesNotDiscovered());
        }
        emit(
          PlacesDiscovered(
            discovered: FoundPlaces(places: places),
          ),
        );
      });

  void _setupTripSubscription() => _tripSubscription = _tripRepository.tripStream.listen((trip) {
        final currentState = state;
        if (currentState is! PlacesDiscovered) {
          return;
        }
        emit(currentState.copyWith(inTrip: trip));
      });

  void _setupRestaurantsSubscription() =>
      _restaurantsSubscription = _placesRepository.restaurantsStream.listen((restaurants) {
        final currentState = state;
        if (currentState is! PlacesDiscovered) {
          return;
        }
        emit(
          currentState.copyWith(
            discovered: FoundPlaces(
              places: currentState.discovered.places,
              restaurants: restaurants,
              cafes: currentState.discovered.cafes,
            ),
          ),
        );
      });

  void _setupCafesSubscription() => _cafesSubscription = _placesRepository.cafesStream.listen((cafes) {
        final currentState = state;
        if (currentState is! PlacesDiscovered) {
          return;
        }
        emit(
          currentState.copyWith(
            discovered: FoundPlaces(
              places: currentState.discovered.places,
              restaurants: currentState.discovered.restaurants,
              cafes: cafes,
            ),
          ),
        );
      });

  // TODO(naz): find optimal route method to sort selected places

  void togglePlace(PointOfInterest place) => _tripRepository.togglePlace(place);

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    _tripSubscription?.cancel();
    _restaurantsSubscription?.cancel();
    _cafesSubscription?.cancel();
    return super.close();
  }
}
