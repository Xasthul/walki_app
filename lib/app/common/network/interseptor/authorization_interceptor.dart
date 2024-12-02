import 'dart:async';

import 'package:dio/dio.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/entity/refresh_token_response.dart';
import 'package:vall/app/common/use_case/secure_storage.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  AuthorizationInterceptor({
    required Dio dio,
    required SecureStorage secureStorage,
    required AuthenticationRepository authenticationRepository,
  })  : _dio = dio,
        _secureStorage = secureStorage,
        _authenticationRepository = authenticationRepository;

  final Dio _dio;
  final SecureStorage _secureStorage;
  final AuthenticationRepository _authenticationRepository;

  Completer<void>? _refreshTokensCompleter;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureStorage.accessToken;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401) {
        if (_refreshTokensCompleter != null) {
          await _refreshTokensCompleter!.future;
        } else {
          await _refreshTokens();
        }

        final newAccessToken = await _secureStorage.accessToken;
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
      } else {
        handler.reject(err);
      }
    } catch (exception) {
      await _authenticationRepository.logOut();
      logger.e('Failed to refresh token');
    }
  }

  Future<void> _refreshTokens() async {
    _refreshTokensCompleter = Completer();
    const url = '${AppConstants.serviceBaseUrl}/auth/refresh-token';
    final refreshToken = await _secureStorage.refreshToken;
    final response = await _dio.post(
      url,
      data: {'refreshToken': refreshToken},
    );
    final tokens = RefreshTokenResponse.fromJson(response.data as Map<String, dynamic>);
    await _secureStorage.saveAccessToken(tokens.accessToken);
    await _secureStorage.saveRefreshToken(tokens.refreshToken);

    _refreshTokensCompleter?.complete();
    _refreshTokensCompleter = null;
  }
}
