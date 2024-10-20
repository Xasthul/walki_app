import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/entity/google_api_lat_lng.dart';
import 'package:vall/home/misc/network/entity/google_api_localized_text.dart';

part 'google_api_place.g.dart';

@JsonSerializable()
class GoogleApiPlace {
  GoogleApiPlace({
    required this.displayName,
    required this.location,
    required this.editorialSummary,
    required this.rating,
  });

  factory GoogleApiPlace.fromJson(Map<String, dynamic> json) => _$GoogleApiPlaceFromJson(json);

  final GoogleApiLocalizedText displayName;
  final GoogleApiLatLng location;
  final GoogleApiLocalizedText? editorialSummary;
  final double rating;

  Map<String, dynamic> toJson() => _$GoogleApiPlaceToJson(this);

  /// Should be one of these: https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places#resource:-place
  static List<String> get props => [
        'displayName',
        'location',
        'editorialSummary',
        'rating',
      ];
}
