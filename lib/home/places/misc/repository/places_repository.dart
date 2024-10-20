import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/logger/logger.dart';
import 'package:vall/home/trip/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/misc/service/points_of_interest_service.dart';

class PlacesRepository {
  PlacesRepository({
    required PointsOfInterestService pointsOfInterestService,
  }) : _pointsOfInterestService = pointsOfInterestService;

  final PointsOfInterestService _pointsOfInterestService;

  final StreamController<List<PointOfInterest>> _placesController = StreamController.broadcast();

  Stream<List<PointOfInterest>> get places => _placesController.stream;

  Future<List<PointOfInterest>> findPlaces({required LatLng startingPosition}) async {
    try {
      final pointsOfInterest = await _pointsOfInterestService.loadPointsOfInterest(
        latitude: startingPosition.latitude,
        longitude: startingPosition.longitude,
        // TODO(naz): should be const?
        maxResultCount: 10,
        radius: 500,
      );

      _placesController.add(pointsOfInterest);
      return pointsOfInterest;
    } catch (error) {
      logger.e('Find places failed', error: error);
      return [];
    }
  }
}
