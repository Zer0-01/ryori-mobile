import 'package:dio/dio.dart';
import 'package:ryori/core/logger/app_logger.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor() : _logger = AppLogger(tag: 'Dio');

  final AppLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('REQ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      'RES ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      'ERR ${err.response?.statusCode ?? '-'} '
      '${err.requestOptions.method} ${err.requestOptions.uri}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
