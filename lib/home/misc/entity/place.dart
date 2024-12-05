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
  List<Object?> get props => [];
}

class GooglePlace extends Place {
  const GooglePlace({
    required super.name,
    required super.latitude,
    required super.longitude,
    required this.photoUrl,
    required this.summary,
    required this.rating,
  });

  final String photoUrl;
  final String? summary;
  final double? rating;

  @override
  List<Object?> get props => super.props
    ..addAll([
      photoUrl,
      summary,
      rating,
    ]);
}

class CustomPlace extends Place {
  const CustomPlace({
    required super.name,
    required super.latitude,
    required super.longitude,
  });
}
