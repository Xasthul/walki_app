import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/request/search_nearby/circle_center_location_restriction.dart';

part 'circle_location_restriction.g.dart';

@JsonSerializable()
class CircleLocationRestriction {
  CircleLocationRestriction({
    required this.center,
    required this.radius,
  });

  factory CircleLocationRestriction.fromJson(Map<String, dynamic> json) => _$CircleLocationRestrictionFromJson(json);

  final CircleCenterLocationRestriction center;
  final double radius;

  Map<String, dynamic> toJson() => _$CircleLocationRestrictionToJson(this);
}
