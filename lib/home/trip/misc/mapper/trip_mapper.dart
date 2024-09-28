import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/misc/entity/point_of_interest.dart';

class TripMapper {
  List<LatLng> mapPointsOfInterestToLatLng(List<PointOfInterest> places) =>
      places.map((place) => LatLng(place.latitude, place.longitude)).toList();
}
