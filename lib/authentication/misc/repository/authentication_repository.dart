import 'package:vall/app/common/use_case/secure_storage.dart';
import 'package:vall/authentication/misc/service/authentication_service.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    required AuthenticationService authenticationService,
    required SecureStorage secureStorage,
  })  : _authenticationService = authenticationService,
        _secureStorage = secureStorage;

  final AuthenticationService _authenticationService;
  final SecureStorage _secureStorage;

  Future<bool> get isAccessTokenStored async => (await _secureStorage.accessToken) != null;

  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async =>
      _authenticationService.register(
        email: email,
        name: name,
        password: password,
      );

  Future<void> login({
    required String email,
    required String password,
  }) async =>
      _authenticationService.login(
        email: email,
        password: password,
      );
}
