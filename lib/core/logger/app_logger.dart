import 'package:logger/logger.dart';

class AppLogger {
  AppLogger({String? tag})
    : _tag = tag,
      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 100,
          colors: true,
          printEmojis: false,
        ),
      );

  final String? _tag;

  String _format(dynamic message) {
    if (_tag == null || _tag.isEmpty) {
      return '$message';
    }

    return '[$_tag] $message';
  }

  final Logger _logger;

  void t(dynamic message) => _logger.t(_format(message));
  void d(dynamic message) => _logger.d(_format(message));
  void i(dynamic message) => _logger.i(_format(message));
  void w(dynamic message) => _logger.w(_format(message));

  void e(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(_format(message), error: error, stackTrace: stackTrace);
  }


  void f(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(_format(message), error: error, stackTrace: stackTrace);
  }
}
