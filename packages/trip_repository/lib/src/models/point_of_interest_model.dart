import 'package:equatable/equatable.dart';

class PointOfInterestModel extends Equatable {
  PointOfInterestModel({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [latitude, longitude];
}
