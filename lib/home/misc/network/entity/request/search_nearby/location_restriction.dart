import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/circle_location_restriction.dart';

part 'location_restriction.g.dart';

@JsonSerializable()
class LocationRestriction {
  LocationRestriction({required this.circle});

  factory LocationRestriction.fromJson(Map<String, dynamic> json) => _$LocationRestrictionFromJson(json);

  final CircleLocationRestriction circle;

  Map<String, dynamic> toJson() => _$LocationRestrictionToJson(this);
}
