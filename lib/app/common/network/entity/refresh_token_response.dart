import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response.g.dart';

@JsonSerializable()
class RefreshTokenResponse {
  RefreshTokenResponse(
      this.accessToken,
      this.refreshToken,
      );

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => _$RefreshTokenResponseFromJson(json);

  final String accessToken;
  final String refreshToken;
}
