import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/env/development/env_development.dart';

class DevelopmentEnv implements AppEnv {
  @override
  String get apiBaseUrl => EnvDevelopment.apiBaseUrl;
}