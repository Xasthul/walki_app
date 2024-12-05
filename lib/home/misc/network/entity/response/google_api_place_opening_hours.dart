import 'package:json_annotation/json_annotation.dart';

part 'google_api_place_opening_hours.g.dart';

@JsonSerializable()
class GoogleApiPlaceOpeningHours {
  GoogleApiPlaceOpeningHours({
    required this.nextOpenTime,
    required this.nextCloseTime,
    required this.openNow,
  });

  factory GoogleApiPlaceOpeningHours.fromJson(Map<String, dynamic> json) => _$GoogleApiPlaceOpeningHoursFromJson(json);

  final String? nextOpenTime;
  final String? nextCloseTime;
  final bool? openNow;

  Map<String, dynamic> toJson() => _$GoogleApiPlaceOpeningHoursToJson(this);
}
