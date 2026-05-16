// lib/app/di/injection.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/env/development/development_env.dart';
import 'package:ryori/core/env/local/local_env.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({required String environment}) async {
  if (getIt.isRegistered<AppEnv>()) {
    await getIt.unregister<AppEnv>();
  }

  getIt.registerLazySingleton<AppEnv>(() => _createAppEnv(environment));
  getIt.init(environment: environment);
}

AppEnv _createAppEnv(String environment) {
  switch (environment) {
    case AppEnvironment.local:
      return LocalEnv();
    case AppEnvironment.development:
      return DevelopmentEnv();
  }

  throw UnsupportedError('Unsupported app environment: $environment');
}
