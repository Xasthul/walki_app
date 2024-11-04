import 'package:json_annotation/json_annotation.dart';

part 'access_token_response.g.dart';

@JsonSerializable()
class AccessTokenResponse {
  AccessTokenResponse(this.accessToken);

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) => _$AccessTokenResponseFromJson(json);

  final String accessToken;
}
