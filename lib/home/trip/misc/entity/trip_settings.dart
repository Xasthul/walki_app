import 'package:equatable/equatable.dart';

class TripSettings extends Equatable {
  const TripSettings({
    required this.searchRadius,
    required this.shouldShowSearchRadius,
  });

  final double searchRadius;
  final bool shouldShowSearchRadius;

  @override
  List<Object?> get props => [
        searchRadius,
        shouldShowSearchRadius,
      ];
}
