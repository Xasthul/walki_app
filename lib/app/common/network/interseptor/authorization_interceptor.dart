import 'package:dio/dio.dart';
import 'package:vall/app/common/logger/logger.dart';
import 'package:vall/app/common/use_case/secure_storage.dart';
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
        final newAccessToken = await _refreshAccessToken();
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

  Future<String> _refreshAccessToken() async {
    throw Exception();
  }
}
