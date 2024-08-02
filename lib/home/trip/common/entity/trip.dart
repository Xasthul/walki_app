import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/common/entity/point_of_interest.dart';

class Trip extends Equatable {
  const Trip({
    required this.startingLocation,
    required this.places,
  });

  final LatLng startingLocation;
  final List<PointOfInterest> places;

  @override
  List<Object> get props => [startingLocation, places];
}
