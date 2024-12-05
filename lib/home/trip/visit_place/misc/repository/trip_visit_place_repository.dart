import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/extension/compare_place_extension.dart';
import 'package:vall/home/profile/misc/entity/visited_place.dart';

class TripVisitPlaceRepository {
  static const _visitThreshold = 50; // in meters

  Place? checkForNearbyPlace({
    required LatLng location,
    required List<Place> places,
    required List<VisitedPlace> visitedPlaces,
  }) {
    for (final place in places) {
      final double distance = Geolocator.distanceBetween(
        location.latitude,
        location.longitude,
        place.latitude,
        place.longitude,
      );

      if (distance < _visitThreshold) {
        final containsPlace = visitedPlaces.any(place.isSameAs);
        if (!containsPlace) {
          return place;
        }
      }
    }
    return null;
  }
}
