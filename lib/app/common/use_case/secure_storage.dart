import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const _accessTokenKey = 'accessToken';

  Future<String?> get accessToken => _storage.read(key: _accessTokenKey);

  Future<void> saveAccessToken(String accessToken) => _storage.write(
        key: _accessTokenKey,
        value: accessToken,
      );
}
