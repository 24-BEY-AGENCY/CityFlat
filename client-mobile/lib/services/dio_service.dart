import 'package:dio/dio.dart';
import '../interceptors/auth_interceptor.dart';

class DioService {
  Dio? _dio;

  DioService() {
    _dio = Dio();
    _dio!.interceptors.add(AuthInterceptor());
  }

  Dio get dio => _dio!;
}
