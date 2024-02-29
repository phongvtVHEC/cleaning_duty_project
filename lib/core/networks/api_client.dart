import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Constants.api_base_url));

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Constants.api_base_url,
      receiveTimeout: const Duration(milliseconds: 15000),
      connectTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
