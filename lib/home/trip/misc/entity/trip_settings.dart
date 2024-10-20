import 'package:equatable/equatable.dart';

class TripSettings extends Equatable {
  const TripSettings({
    required this.searchRadius,
  });

  final double searchRadius;

  @override
  List<Object?> get props => [searchRadius];
}
