import 'package:equatable/equatable.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';

class FoundPlaces extends Equatable {
  const FoundPlaces({
    required this.places,
    required this.restaurants,
    required this.cafes,
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
