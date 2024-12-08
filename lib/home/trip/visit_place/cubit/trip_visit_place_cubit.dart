import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';
import 'package:vall/home/profile/misc/entity/visited_place.dart';
import 'package:vall/home/profile/misc/repository/visited_places_repository.dart';
import 'package:vall/home/trip/visit_place/misc/mapper/visited_place_mapper.dart';
import 'package:vall/home/trip/visit_place/misc/repository/trip_visit_place_repository.dart';

part 'trip_visit_place_state.dart';

class TripVisitPlaceCubit extends Cubit<TripVisitPlaceState> {
  TripVisitPlaceCubit({
    required CurrentLocationRepository currentLocationRepository,
    required VisitedPlacesRepository visitedPlacesRepository,
    required TripVisitPlaceRepository tripVisitPlaceRepository,
    required VisitedPlaceMapper visitedPlaceMapper,
  })  : _currentLocationRepository = currentLocationRepository,
        _visitedPlacesRepository = visitedPlacesRepository,
        _tripVisitPlaceRepository = tripVisitPlaceRepository,
        _visitedPlaceMapper = visitedPlaceMapper,
        super(TripVisitPlaceInitial());

  final CurrentLocationRepository _currentLocationRepository;
  final VisitedPlacesRepository _visitedPlacesRepository;
  final TripVisitPlaceRepository _tripVisitPlaceRepository;
  final VisitedPlaceMapper _visitedPlaceMapper;

  StreamSubscription<LatLng>? _currentLocationSubscription;

  Future<void> load() async {
    try {
      final visitedPlaces = await _visitedPlacesRepository.loadVisitedPlaces();
      emit(TripVisitPlaceLoaded(visitedPlaces: visitedPlaces));
    } catch (error, stackTrace) {
      logger.e('Failed to load visited places', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> onTripCreated({required List<Place> places}) async =>
      _currentLocationSubscription = _currentLocationRepository.currentLocationStream.listen((location) async {
        if (state is TripVisitPlaceReached) {
          return;
        }
        final approachedPlace = _tripVisitPlaceRepository.checkForNearbyPlace(
          location: location,
          places: places,
          visitedPlaces: state.visitedPlaces,
        );
        if (approachedPlace == null || approachedPlace is! GooglePlace) {
          return;
        }
        emit(
          TripVisitPlaceReached(
            place: approachedPlace,
            visitedPlaces: state.visitedPlaces,
          ),
        );
      });

  Future<void> markPlaceAsVisited(GooglePlace place) async {
    try {
      final visitedPlace = _visitedPlaceMapper.mapVisitedPlaceFromPlace(place);
      await _visitedPlacesRepository.visitPlace(
        googlePlaceId: place.id,
        place: visitedPlace,
      );
      emit(TripVisitPlaceMarked(visitedPlaces: [...state.visitedPlaces, visitedPlace]));
    } catch (error, stackTrace) {
      logger.e('Visit place failed', error: error, stackTrace: stackTrace);
    }
  }

  void onTripFinished() => _currentLocationSubscription?.cancel();
}
