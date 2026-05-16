abstract class AppEnv {
  String get apiBaseUrl;
}

final class AppEnvironment {
  const AppEnvironment._();

  static const String local = 'local';
  static const String development = 'development';
}
