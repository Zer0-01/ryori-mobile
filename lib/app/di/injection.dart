import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/env/development/development_env.dart';
import 'package:ryori/core/env/local/local_env.dart';
import 'package:ryori/core/network/dio_client.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({required String environment}) async {
  if (getIt.isRegistered<AppEnv>()) {
    await getIt.unregister<AppEnv>();
  }
  if (getIt.isRegistered<FlutterSecureStorage>()) {
    await getIt.unregister<FlutterSecureStorage>();
  }
  if (getIt.isRegistered<AuthTokenStorage>()) {
    await getIt.unregister<AuthTokenStorage>();
  }
  if (getIt.isRegistered<DioClient>()) {
    await getIt.unregister<DioClient>();
  }
  if (getIt.isRegistered<Dio>()) {
    await getIt.unregister<Dio>();
  }

  getIt.registerLazySingleton<AppEnv>(() => _createAppEnv(environment));
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<AuthTokenStorage>(
    () => AuthTokenStorage(getIt<FlutterSecureStorage>()),
  );
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      appEnv: getIt<AppEnv>(),
      authTokenStorage: getIt<AuthTokenStorage>(),
    ),
  );
  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio);
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
