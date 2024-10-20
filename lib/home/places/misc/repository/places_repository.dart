import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/logger/logger.dart';
import 'package:vall/home/misc/mapper/point_of_interest_mapper.dart';
import 'package:vall/home/misc/service/points_of_interest_service.dart';

class PlacesRepository {
  PlacesRepository({
    required PointsOfInterestService pointsOfInterestService,
    required PointOfInterestMapper pointOfInterestMapper,
  })  : _pointsOfInterestService = pointsOfInterestService,
        _pointOfInterestMapper = pointOfInterestMapper;

  final PointsOfInterestService _pointsOfInterestService;
  final PointOfInterestMapper _pointOfInterestMapper;

  final StreamController<List<PointOfInterest>> _placesController = StreamController.broadcast();

  Stream<List<PointOfInterest>> get places => _placesController.stream;

  Future<List<PointOfInterest>> findPlaces({required LatLng startingPosition}) async {
    try {
      final googleApiPlaces = await _pointsOfInterestService.loadPointsOfInterest(
        latitude: startingPosition.latitude,
        longitude: startingPosition.longitude,
        // TODO(naz): should be const?
        maxResultCount: 10,
        radius: 500,
      );
      final pointsOfInterest = googleApiPlaces
          .map(
            (place) => _pointOfInterestMapper.mapFromGoogleApiPlace(place),
          )
          .toList();

      _placesController.add(pointsOfInterest);
      return pointsOfInterest;
    } catch (error) {
      logger.e('Find places failed', error: error);
      return [];
    }
  }
}
