abstract class AppEnv {
  String get apiBaseUrl;
  String get authRegisterEndpoint;
  String get authLoginEndpoint;
  String get authRefreshEndpoint;
  String get authLogoutEndpoint;
  String get profileEndpoint;
}

final class AppEnvironment {
  const AppEnvironment._();

  static const String local = 'local';
  static const String development = 'development';
}
