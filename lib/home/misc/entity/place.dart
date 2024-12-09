import 'package:equatable/equatable.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/search_nearby_place_type.dart';

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
    required this.type,
  });

  final String id;
  final String photoUrl;
  final String? summary;
  final double? rating;
  final bool? isOpen;
  final DateTime? nextOpenTime; // Local time
  final DateTime? nextCloseTime; // Local time
  final SearchNearbyPlaceType type;

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
      type,
    ]);
}

class CustomPlace extends Place {
  const CustomPlace({
    required super.name,
    required super.latitude,
    required super.longitude,
  });
}
