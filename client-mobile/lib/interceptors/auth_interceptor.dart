import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  static const _secureStorage = FlutterSecureStorage();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await _secureStorage.read(key: 'token');

    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }
}
