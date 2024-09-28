import 'package:equatable/equatable.dart';

class PointOfInterest extends Equatable {
  const PointOfInterest({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [
        name,
        latitude,
        longitude,
      ];
}
