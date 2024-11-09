import 'dart:async';

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

  static bool _isAuthenticated(String? accessToken) => accessToken != null;

  Future<bool> get isAuthenticated async => _isAuthenticated(await _secureStorage.accessToken);

  Stream<bool> get isAuthenticatedStream => _secureStorage.accessTokenStream.transform(_accessTokenTransformer);

  final _accessTokenTransformer = StreamTransformer<String?, bool>.fromHandlers(
    handleData: (accessToken, sink) {
      final isAuthenticated = _isAuthenticated(accessToken);
      sink.add(isAuthenticated);
    },
  );

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
  }) async {
    final accessToken = await _authenticationService.login(
      email: email,
      password: password,
    );
    await _secureStorage.saveAccessToken(accessToken);
  }

  Future<void> logOut() async => _secureStorage.removeAccessToken();
}
