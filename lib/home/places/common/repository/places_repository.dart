import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/common/entity/point_of_interest.dart';
import 'package:vall/home/trip/common/service/point_of_interest_service.dart';

class PlacesRepository {
  PlacesRepository({
    required PointOfInterestService pointOfInterestService,
  }) : _pointOfInterestService = pointOfInterestService;

  final PointOfInterestService _pointOfInterestService;

  final StreamController<List<PointOfInterest>> _placesController = StreamController.broadcast();

  Stream<List<PointOfInterest>> get places => _placesController.stream;

  Future<List<PointOfInterest>> findPlaces({required LatLng startingPosition}) async {
    final pointsOfInterest = await _pointOfInterestService.loadPointsOfInterest(
      latitude: startingPosition.latitude,
      longitude: startingPosition.longitude,
    );

    _placesController.add(pointsOfInterest);
    return pointsOfInterest;
  }
}
