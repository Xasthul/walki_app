import 'package:equatable/equatable.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';

class FoundPlaces extends Equatable {
  const FoundPlaces({
    this.places = const [],
    this.restaurants = const [],
    this.cafes = const [],
  });

  final List<PointOfInterest> places;
  final List<PointOfInterest> restaurants;
  final List<PointOfInterest> cafes;

  @override
  List<Object?> get props => [
        places,
        restaurants,
        cafes,
      ];
}
