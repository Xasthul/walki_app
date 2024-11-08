import 'package:vall/home/profile/utils/entity/user.dart';
import 'package:vall/home/profile/utils/service/user_service.dart';

class UserRepository {
  UserRepository({
    required UserService userService,
  }) : _userService = userService;

  final UserService _userService;

  Future<User> loadUserData() async {
    final response = await _userService.getUserData();
    return User(
      email: response.email,
      name: response.name,
    );
  }
}
