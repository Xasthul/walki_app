import 'package:dio/dio.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/app/common/network/interseptor/authorization_interceptor.dart';
import 'package:vall/app/common/use_case/secure_storage.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';

class DioClientFactory {
  static GenericDioClient createGenericDioClient() {
    final headers = {'Content-Type': 'application/json'};
    final dio = Dio(BaseOptions(headers: headers));
    dio.interceptors.add(LogInterceptor());
    return GenericDioClient(dio: dio);
  }

  static GoogleApiDioClient createGoogleApiDioClient() {
    final headers = {
      'X-Goog-Api-Key': AppConstants.googleApiKey,
      'Content-Type': 'application/json',
    };
    final dio = Dio(BaseOptions(headers: headers));
    dio.interceptors.add(LogInterceptor());
    return GoogleApiDioClient(dio: dio);
  }

  static AuthorizedDioClient createAuthorizedDioClient({
    required SecureStorage secureStorage,
    required AuthenticationRepository authenticationRepository,
  }) {
    final headers = {'Content-Type': 'application/json'};
    final dio = Dio(BaseOptions(headers: headers));
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(
      AuthorizationInterceptor(
        dio: dio,
        secureStorage: secureStorage,
        authenticationRepository: authenticationRepository,
      ),
    );
    return AuthorizedDioClient(dio: dio);
  }
}
