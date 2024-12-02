import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/authentication/misc/network/login_response.dart';

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
    const url = '${AppConstants.serviceBaseUrl}/auth/sign-up';

    await _client.post(
      url,
      body: {
        'email': email,
        'name': name,
        'password': password,
      },
    );
  }

  Future<LoginResponse> login({
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

    return LoginResponse.fromJson(response);
  }
}
