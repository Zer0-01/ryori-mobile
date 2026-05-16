import 'package:injectable/injectable.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/env/local/env_local.dart';

@LazySingleton(as: AppEnv, env: [AppEnvironment.local])
class LocalEnv implements AppEnv {
  @override
  String get apiBaseUrl => EnvLocal.apiBaseUrl;

  @override
  String get authRegisterEndpoint => EnvLocal.authRegisterEndpoint;

  @override
  String get authLoginEndpoint => EnvLocal.authLoginEndpoint;

  @override
  String get authRefreshEndpoint => EnvLocal.authRefreshEndpoint;

  @override
  String get authLogoutEndpoint => EnvLocal.authLogoutEndpoint;

  @override
  String get profileEndpoint => EnvLocal.profileEndpoint;
}
