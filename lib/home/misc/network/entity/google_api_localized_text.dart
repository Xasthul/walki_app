import 'package:json_annotation/json_annotation.dart';

part 'google_api_localized_text.g.dart';

@JsonSerializable()
class GoogleApiLocalizedText {
  GoogleApiLocalizedText({
    required this.text,
    required this.languageCode,
  });

  factory GoogleApiLocalizedText.fromJson(Map<String, dynamic> json) => _$GoogleApiLocalizedTextFromJson(json);

  final String text;
  final String languageCode;

  Map<String, dynamic> toJson() => _$GoogleApiLocalizedTextToJson(this);
}
