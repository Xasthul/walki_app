import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/logger/logger.dart';
import 'package:vall/home/misc/mapper/point_of_interest_mapper.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/search_nearby_place_type.dart';
import 'package:vall/home/misc/service/google_api_service.dart';

class PlacesRepository {
  PlacesRepository({
    required GoogleApiService googleApiService,
    required PointOfInterestMapper pointOfInterestMapper,
  })  : _googleApiService = googleApiService,
        _pointOfInterestMapper = pointOfInterestMapper;

  final GoogleApiService _googleApiService;
  final PointOfInterestMapper _pointOfInterestMapper;

  final StreamController<List<PointOfInterest>> _placesController = StreamController.broadcast();
  final StreamController<List<PointOfInterest>> _restaurantsController = StreamController.broadcast();
  final StreamController<List<PointOfInterest>> _cafesController = StreamController.broadcast();

  Stream<List<PointOfInterest>> get placesStream => _placesController.stream;

  Stream<List<PointOfInterest>> get restaurantsStream => _restaurantsController.stream;

  Stream<List<PointOfInterest>> get cafesStream => _cafesController.stream;

  Future<List<PointOfInterest>> findPlaces({
    required LatLng startingPosition,
    required double radius,
  }) async {
    try {
      final pointsOfInterest = await _loadPlaces(
        placeType: SearchNearbyPlaceType.touristAttraction,
        startingPosition: startingPosition,
        radius: radius,
      );

      _placesController.add(pointsOfInterest);
      return pointsOfInterest;
    } catch (error, stackTrace) {
      logger.e('Find places failed', error: error, stackTrace: stackTrace);
      return [];
    }
  }

  Future<List<PointOfInterest>> findRestaurants({
    required LatLng startingPosition,
    required double radius,
  }) async {
    try {
      final pointsOfInterest = await _loadPlaces(
        placeType: SearchNearbyPlaceType.restaurant,
        startingPosition: startingPosition,
        radius: radius,
      );

      _restaurantsController.add(pointsOfInterest);
      return pointsOfInterest;
    } catch (error, stackTrace) {
      logger.e('Find places failed', error: error, stackTrace: stackTrace);
      return [];
    }
  }

  Future<List<PointOfInterest>> findCafes({
    required LatLng startingPosition,
    required double radius,
  }) async {
    try {
      final pointsOfInterest = await _loadPlaces(
        placeType: SearchNearbyPlaceType.cafe,
        startingPosition: startingPosition,
        radius: radius,
      );

      _cafesController.add(pointsOfInterest);
      return pointsOfInterest;
    } catch (error, stackTrace) {
      logger.e('Find places failed', error: error, stackTrace: stackTrace);
      return [];
    }
  }

  Future<List<PointOfInterest>> _loadPlaces({
    required SearchNearbyPlaceType placeType,
    required LatLng startingPosition,
    required double radius,
  }) async {
    final googleApiPlaces = await _googleApiService.searchPlacesNearby(
      placeType: placeType,
      latitude: startingPosition.latitude,
      longitude: startingPosition.longitude,
      // TODO(naz): should be const?
      maxResultCount: 10,
      radius: radius,
    );
    return googleApiPlaces
        .map(
          (place) => _pointOfInterestMapper.mapFromGoogleApiPlace(place),
        )
        .toList();
  }
}
