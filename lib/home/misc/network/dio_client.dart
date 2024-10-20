import 'package:dio/dio.dart';

class GoogleApiDioClient extends _DioClient {
  GoogleApiDioClient({required super.dio});
}

class GenericDioClient extends _DioClient {
  GenericDioClient({required super.dio});
}

abstract class _DioClient {
  _DioClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String>? params,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _dio.post<dynamic>(
      url,
      queryParameters: params,
      options: Options(
        headers: {
          ..._dio.options.headers,
          if (headers != null) ...headers,
        },
      ),
      data: body,
    );
    if (response.data is String || (response.statusCode == 204 && response.data == null)) {
      return <String, dynamic>{};
    }
    return response.data as Map<String, dynamic>;
  }
}
