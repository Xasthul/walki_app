import 'package:equatable/equatable.dart';

abstract class Place extends Equatable {
  const Place({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [
        name,
        latitude,
        longitude,
      ];
}

class GooglePlace extends Place {
  const GooglePlace({
    required super.name,
    required super.latitude,
    required super.longitude,
    required this.id,
    required this.photoUrl,
    required this.summary,
    required this.rating,
    required this.isOpen,
    required this.nextOpenTime,
    required this.nextCloseTime,
  });

  final String id;
  final String photoUrl;
  final String? summary;
  final double? rating;
  final bool? isOpen;
  final DateTime? nextOpenTime; // Local time
  final DateTime? nextCloseTime; // Local time

  @override
  List<Object?> get props => super.props
    ..addAll([
      id,
      photoUrl,
      summary,
      rating,
      isOpen,
      nextOpenTime,
      nextCloseTime,
    ]);
}

class CustomPlace extends Place {
  const CustomPlace({
    required super.name,
    required super.latitude,
    required super.longitude,
  });
}
