import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  final StreamController<String?> _accessTokenController = StreamController.broadcast();

  Stream<String?> get accessTokenStream => _accessTokenController.stream;

  Future<String?> get accessToken => _storage.read(key: _accessTokenKey);

  Future<String?> get refreshToken => _storage.read(key: _refreshTokenKey);

  void load() => _storage.registerListener(
        key: _accessTokenKey,
        listener: _onAccessTokenChanged,
      );

  void _onAccessTokenChanged(String? accessToken) => _accessTokenController.add(accessToken);

  Future<void> saveAccessToken(String accessToken) => _storage.write(
        key: _accessTokenKey,
        value: accessToken,
      );

  Future<void> saveRefreshToken(String refreshToken) => _storage.write(
        key: _refreshTokenKey,
        value: refreshToken,
      );

  Future<void> clearTokens() async {
    await _storage.write(key: _accessTokenKey, value: null);
    await _storage.write(key: _refreshTokenKey, value: null);
  }
}
