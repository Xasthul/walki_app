import 'package:json_annotation/json_annotation.dart';

part 'circle_center_location_restriction.g.dart';

@JsonSerializable()
class CircleCenterLocationRestriction {
  CircleCenterLocationRestriction({
    required this.latitude,
    required this.longitude,
  });

  factory CircleCenterLocationRestriction.fromJson(Map<String, dynamic> json) =>
      _$CircleCenterLocationRestrictionFromJson(json);

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$CircleCenterLocationRestrictionToJson(this);
}
