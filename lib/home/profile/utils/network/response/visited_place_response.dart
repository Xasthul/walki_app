import 'package:json_annotation/json_annotation.dart';

part 'visited_place_response.g.dart';

@JsonSerializable()
class VisitedPlaceResponse {
  VisitedPlaceResponse(this.name, this.latitude, this.longitude);

  factory VisitedPlaceResponse.fromJson(Map<String, dynamic> json) => _$VisitedPlaceResponseFromJson(json);

  final String name;
  final double latitude;
  final double longitude;
}
