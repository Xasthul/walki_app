import 'package:equatable/equatable.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';

class Trip extends Equatable {
  const Trip({required this.places});

  factory Trip.empty() => const Trip(places: []);

  final List<PointOfInterest> places;

  Trip copyWith({
    List<PointOfInterest>? places,
  }) =>
      Trip(
        places: places ?? this.places,
      );

  @override
  List<Object> get props => [places];
}
