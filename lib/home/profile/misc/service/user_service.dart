import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/home/profile/misc/network/response/user_response.dart';

class UserService {
  UserService({
    required AuthorizedDioClient client,
  }) : _client = client;

  final AuthorizedDioClient _client;

  Future<UserResponse> getUserData() async {
    const url = '${AppConstants.serviceBaseUrl}/users/profile';
    final response = await _client.get(url);
    return UserResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<void> deleteAccount() async {
    const url = '${AppConstants.serviceBaseUrl}/users';
    await _client.delete(url);
  }
}
