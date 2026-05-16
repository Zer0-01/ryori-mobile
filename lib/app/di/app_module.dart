import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';
import 'package:ryori/core/auth/data/auth_remote_data_source.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/network/interceptors/auth_interceptor.dart';
import 'package:ryori/core/network/interceptors/logger_interceptor.dart';

@module
abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  @lazySingleton
  @Named('authDio')
  Dio authDio(AppEnv appEnv) {
    final dio = Dio(
      BaseOptions(
        baseUrl: appEnv.apiBaseUrl,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(LoggerInterceptor());

    return dio;
  }

  @lazySingleton
  @Named('apiDio')
  Dio apiDio(
    AppEnv appEnv,
    AuthTokenStorage authTokenStorage,
    AuthRemoteDataSource authRemoteDataSource,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: appEnv.apiBaseUrl,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.addAll([
      AuthInterceptor(
        dio: dio,
        authTokenStorage: authTokenStorage,
        authRemoteDataSource: authRemoteDataSource,
      ),
      LoggerInterceptor(),
    ]);

    return dio;
  }
}
