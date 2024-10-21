import 'package:equatable/equatable.dart';
import 'package:vall/home/trip/misc/entity/trip_travel_mode.dart';

class TripSettings extends Equatable {
  const TripSettings({
    required this.searchRadius,
    required this.travelMode,
  });

  final double searchRadius;
  final TripTravelMode travelMode;

  @override
  List<Object?> get props => [
        searchRadius,
        travelMode,
      ];
}
