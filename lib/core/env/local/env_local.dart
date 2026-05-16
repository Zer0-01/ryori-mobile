import 'package:envied/envied.dart';

part 'env_local.g.dart';

@Envied(path: '.env.local')
abstract class EnvLocal {
  @EnviedField(varName: 'API_BASE_URL')
  static String apiBaseUrl = _EnvLocal.apiBaseUrl;

  @EnviedField(varName: 'AUTH_REGISTER_ENDPOINT')
  static String authRegisterEndpoint = _EnvLocal.authRegisterEndpoint;

  @EnviedField(varName: 'AUTH_LOGIN_ENDPOINT')
  static String authLoginEndpoint = _EnvLocal.authLoginEndpoint;

  @EnviedField(varName: 'AUTH_REFRESH_ENDPOINT')
  static String authRefreshEndpoint = _EnvLocal.authRefreshEndpoint;

  @EnviedField(varName: 'AUTH_LOGOUT_ENDPOINT')
  static String authLogoutEndpoint = _EnvLocal.authLogoutEndpoint;

  @EnviedField(varName: 'PROFILE_ENDPOINT')
  static String profileEndpoint = _EnvLocal.profileEndpoint;
}
