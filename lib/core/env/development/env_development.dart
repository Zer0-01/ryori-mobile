import 'package:envied/envied.dart';

part 'env_development.g.dart';

@Envied(path: '.env.development')
abstract class EnvDevelopment {
  @EnviedField(varName: 'API_BASE_URL')
  static String apiBaseUrl = _EnvDevelopment.apiBaseUrl;
}