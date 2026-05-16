import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/env/local/env_local.dart';

class LocalEnv implements AppEnv {
  @override
  String get apiBaseUrl => EnvLocal.apiBaseUrl;
}