import 'package:json_annotation/json_annotation.dart';

part 'google_api_place_photo.g.dart';

@JsonSerializable()
class GoogleApiPlacePhoto {
  GoogleApiPlacePhoto({
    required this.name,
  });

  factory GoogleApiPlacePhoto.fromJson(Map<String, dynamic> json) => _$GoogleApiPlacePhotoFromJson(json);

  final String name;

  Map<String, dynamic> toJson() => _$GoogleApiPlacePhotoToJson(this);
}
