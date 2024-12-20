import 'package:json_annotation/json_annotation.dart';

part 'place_review_response.g.dart';

@JsonSerializable()
class PlaceReviewResponse {
  PlaceReviewResponse({
    required this.author,
    required this.content,
    required this.createdAt,
  });

  factory PlaceReviewResponse.fromJson(Map<String, dynamic> json) => _$PlaceReviewResponseFromJson(json);

  final String author;
  final String content;
  final String createdAt;

  Map<String, dynamic> toJson() => _$PlaceReviewResponseToJson(this);
}
