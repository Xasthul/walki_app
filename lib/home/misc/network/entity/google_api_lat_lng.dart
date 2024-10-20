import 'package:json_annotation/json_annotation.dart';

part 'google_api_lat_lng.g.dart';

@JsonSerializable()
class GoogleApiLatLng {
  GoogleApiLatLng({
    required this.latitude,
    required this.longitude,
  });

  factory GoogleApiLatLng.fromJson(Map<String, dynamic> json) => _$GoogleApiLatLngFromJson(json);

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$GoogleApiLatLngToJson(this);
}
