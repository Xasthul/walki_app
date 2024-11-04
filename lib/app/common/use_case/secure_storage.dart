import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const _accessTokenKey = 'accessToken';

  final StreamController<String?> _accessTokenController = StreamController.broadcast();

  Stream<String?> get accessTokenStream => _accessTokenController.stream;

  void load() => _storage.registerListener(
        key: _accessTokenKey,
        listener: _onAccessTokenChanged,
      );

  void _onAccessTokenChanged(String? accessToken) => _accessTokenController.add(accessToken);

  Future<String?> get accessToken => _storage.read(key: _accessTokenKey);

  Future<void> saveAccessToken(String accessToken) => _storage.write(
        key: _accessTokenKey,
        value: accessToken,
      );
}
