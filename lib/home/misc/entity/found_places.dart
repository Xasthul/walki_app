import 'package:equatable/equatable.dart';
import 'package:vall/home/misc/entity/place.dart';

class FoundPlaces extends Equatable {
  const FoundPlaces({
    required this.places,
    required this.restaurants,
    required this.cafes,
  });

  final List<GooglePlace> places;
  final List<GooglePlace> restaurants;
  final List<GooglePlace> cafes;

  @override
  List<Object?> get props => [
        places,
        restaurants,
        cafes,
      ];
}
