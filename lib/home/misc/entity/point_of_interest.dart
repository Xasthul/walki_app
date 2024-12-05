import 'package:equatable/equatable.dart';

class PointOfInterest extends Equatable {
  const PointOfInterest({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
  });

  final String name;
  final double latitude;
  final double longitude;
  final String photoUrl;

  @override
  List<Object> get props => [
        name,
        latitude,
        longitude,
        photoUrl,
      ];
}
