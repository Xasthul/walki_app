import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/entity/google_api_lat_lng.dart';
import 'package:vall/home/misc/network/entity/google_api_localized_text.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place_opening_hours.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place_photo.dart';

part 'google_api_place.g.dart';

@JsonSerializable()
class GoogleApiPlace {
  GoogleApiPlace({
    required this.displayName,
    required this.location,
    required this.editorialSummary,
    required this.rating,
    required this.photos,
    required this.currentOpeningHours,
  });

  factory GoogleApiPlace.fromJson(Map<String, dynamic> json) => _$GoogleApiPlaceFromJson(json);

  final GoogleApiLocalizedText displayName;
  final GoogleApiLatLng location;
  final GoogleApiLocalizedText? editorialSummary;
  final double? rating;
  final List<GoogleApiPlacePhoto> photos;
  final GoogleApiPlaceOpeningHours? currentOpeningHours;

  Map<String, dynamic> toJson() => _$GoogleApiPlaceToJson(this);

  /// Should be one of these: https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places#resource:-place
  static List<String> get props => [
        'displayName',
        'location',
        'editorialSummary',
        'rating',
        'photos',
        'currentOpeningHours',
      ];
}
