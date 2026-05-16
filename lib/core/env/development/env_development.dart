import 'package:envied/envied.dart';

part 'env_development.g.dart';

@Envied(path: '.env.development')
abstract class EnvDevelopment {
  @EnviedField(varName: 'API_BASE_URL')
  static String apiBaseUrl = _EnvDevelopment.apiBaseUrl;

  @EnviedField(varName: 'AUTH_REGISTER_ENDPOINT')
  static String authRegisterEndpoint = _EnvDevelopment.authRegisterEndpoint;

  @EnviedField(varName: 'AUTH_LOGIN_ENDPOINT')
  static String authLoginEndpoint = _EnvDevelopment.authLoginEndpoint;

  @EnviedField(varName: 'AUTH_REFRESH_ENDPOINT')
  static String authRefreshEndpoint = _EnvDevelopment.authRefreshEndpoint;

  @EnviedField(varName: 'AUTH_LOGOUT_ENDPOINT')
  static String authLogoutEndpoint = _EnvDevelopment.authLogoutEndpoint;

  @EnviedField(varName: 'PROFILE_ENDPOINT')
  static String profileEndpoint = _EnvDevelopment.profileEndpoint;
}
