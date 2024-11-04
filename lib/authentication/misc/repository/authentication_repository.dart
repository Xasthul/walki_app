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

  final StreamController<bool> _isAuthenticatedController = StreamController.broadcast();
  StreamSubscription<String?>? _accessTokenSubscription;

  Stream<bool> get isAuthenticatedStream => _isAuthenticatedController.stream;

  void load() {
    _accessTokenSubscription = _secureStorage.accessTokenStream.listen(_updateIsAuthenticated);
  }

  void _updateIsAuthenticated(String? accessToken) {
    final isAuthenticated = _isAuthenticated(accessToken);
    _isAuthenticatedController.add(isAuthenticated);
  }

  Future<bool> get isAuthenticated async => _isAuthenticated(await _secureStorage.accessToken);

  bool _isAuthenticated(String? accessToken) => accessToken != null;

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

  void dispose() {
    _accessTokenSubscription?.cancel();
  }
}
