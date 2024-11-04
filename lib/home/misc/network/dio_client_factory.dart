import 'package:dio/dio.dart';
import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/misc/network/dio_client.dart';

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

  static AuthorizedDioClient createAuthorizedDioClient() {
    final headers = {
      'Bearer': '',
      'Content-Type': 'application/json',
    };
    final dio = Dio(BaseOptions(headers: headers));
    dio.interceptors.add(LogInterceptor());
    return AuthorizedDioClient(dio: dio);
  }
}
