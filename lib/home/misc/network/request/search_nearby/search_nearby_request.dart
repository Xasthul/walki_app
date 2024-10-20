import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/entity/search_nearby_place_type.dart';
import 'package:vall/home/misc/network/request/search_nearby/location_restriction.dart';

part 'search_nearby_request.g.dart';

@JsonSerializable()
class SearchNearbyRequest {
  SearchNearbyRequest({
    required this.includedTypes,
    required this.maxResultCount,
    required this.locationRestriction,
  });

  factory SearchNearbyRequest.fromJson(Map<String, dynamic> json) => _$SearchNearbyRequestFromJson(json);

  final List<SearchNearbyPlaceType> includedTypes;
  final int maxResultCount;
  final LocationRestriction locationRestriction;

  Map<String, dynamic> toJson() => _$SearchNearbyRequestToJson(this);
}
