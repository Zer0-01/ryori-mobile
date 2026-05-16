import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/env/development/env_development.dart';

class DevelopmentEnv implements AppEnv {
  @override
  String get apiBaseUrl => EnvDevelopment.apiBaseUrl;

  @override
  String get authRegisterEndpoint => EnvDevelopment.authRegisterEndpoint;

  @override
  String get authLoginEndpoint => EnvDevelopment.authLoginEndpoint;

  @override
  String get authRefreshEndpoint => EnvDevelopment.authRefreshEndpoint;

  @override
  String get authLogoutEndpoint => EnvDevelopment.authLogoutEndpoint;

  @override
  String get profileEndpoint => EnvDevelopment.profileEndpoint;
}
