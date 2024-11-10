import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';

class TripVisitPlaceRepository {
  static const _visitThreshold = 50; // in meters

  PointOfInterest? checkForNearbyPlace({
    required LatLng location,
    required List<PointOfInterest> places,
    required List<PointOfInterest> visitedPlaces,
  }) {
    for (final place in places) {
      final double distance = Geolocator.distanceBetween(
        location.latitude,
        location.longitude,
        place.latitude,
        place.longitude,
      );

      if (distance < _visitThreshold) {
        if (!visitedPlaces.contains(place)) {
          return place;
        }
      }
    }
    return null;
  }
}
