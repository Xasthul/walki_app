import 'package:json_annotation/json_annotation.dart';
import 'package:vall/home/misc/network/entity/google_api_lat_lng.dart';

part 'circle_location_restriction.g.dart';

@JsonSerializable()
class CircleLocationRestriction {
  CircleLocationRestriction({
    required this.center,
    required this.radius,
  });

  factory CircleLocationRestriction.fromJson(Map<String, dynamic> json) => _$CircleLocationRestrictionFromJson(json);

  final GoogleApiLatLng center;
  final double radius;

  Map<String, dynamic> toJson() => _$CircleLocationRestrictionToJson(this);
}
