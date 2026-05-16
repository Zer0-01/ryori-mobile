import 'package:envied/envied.dart';

part 'env_local.g.dart';

@Envied(path: '.env.local')
abstract class EnvLocal {
  @EnviedField(varName: 'API_BASE_URL')
  static String apiBaseUrl = _EnvLocal.apiBaseUrl;
}