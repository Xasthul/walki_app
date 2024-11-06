import 'package:equatable/equatable.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';

class TripPlaces extends Equatable {
  const TripPlaces({
    required this.discoveredPlaces,
    required this.customPlaces,
  });

  final List<PointOfInterest> discoveredPlaces;
  final List<PointOfInterest> customPlaces;

  bool get isEmpty => discoveredPlaces.isEmpty && customPlaces.isEmpty;

  TripPlaces copyWith({
    List<PointOfInterest>? discoveredPlaces,
    List<PointOfInterest>? customPlaces,
  }) =>
      TripPlaces(
        discoveredPlaces: discoveredPlaces ?? this.discoveredPlaces,
        customPlaces: customPlaces ?? this.customPlaces,
      );

  @override
  List<Object?> get props => [
        discoveredPlaces,
        customPlaces,
      ];
}
