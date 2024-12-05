import 'package:equatable/equatable.dart';

class VisitedPlace extends Equatable {
  const VisitedPlace({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [name, latitude, longitude];
}
