import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse(
    this.accessToken,
    this.refreshToken,
  );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  final String accessToken;
  final String refreshToken;
}
