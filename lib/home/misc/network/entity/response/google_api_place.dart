import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/entity/google_api_lat_lng.dart';
import 'package:vall/home/misc/network/entity/google_api_localized_text.dart';

part 'google_api_place.g.dart';

@JsonSerializable()
class GoogleApiPlace {
  GoogleApiPlace({
    required this.displayName,
    required this.location,
  });

  factory GoogleApiPlace.fromJson(Map<String, dynamic> json) => _$GoogleApiPlaceFromJson(json);

  final GoogleApiLocalizedText displayName;
  final GoogleApiLatLng location;

  Map<String, dynamic> toJson() => _$GoogleApiPlaceToJson(this);

  static String get fieldMask => '';
}
