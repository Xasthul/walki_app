import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/authentication/misc/network/access_token_response.dart';
import 'package:vall/home/misc/network/dio_client.dart';

class AuthenticationService {
  AuthenticationService({
    required GenericDioClient client,
  }) : _client = client;

  final GenericDioClient _client;

  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async {
    const url = '${AppConstants.serviceBaseUrl}/auth/signup';

    await _client.post(
      url,
      body: {
        'email': email,
        'name': name,
        'password': password,
      },
    );
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    const url = '${AppConstants.serviceBaseUrl}/auth/login';

    final response = await _client.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    return AccessTokenResponse.fromJson(response).accessToken;
  }
}
