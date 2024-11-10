import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place.dart';

part 'search_nearby_response.g.dart';

@JsonSerializable()
class SearchNearbyResponse {
  SearchNearbyResponse({required this.places});

  factory SearchNearbyResponse.fromJson(Map<String, dynamic> json) => _$SearchNearbyResponseFromJson(json);

  final List<GoogleApiPlace>? places;

  Map<String, dynamic> toJson() => _$SearchNearbyResponseToJson(this);
}
