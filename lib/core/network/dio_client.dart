import 'package:dio/dio.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';
import 'package:ryori/core/auth/data/auth_remote_data_source.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/core/network/interceptors/auth_interceptor.dart';
import 'package:ryori/core/network/interceptors/logger_interceptor.dart';

class DioClient {
  DioClient({
    required AppEnv appEnv,
    required AuthTokenStorage authTokenStorage,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: appEnv.apiBaseUrl,
           headers: const {
             'Content-Type': 'application/json',
             'Accept': 'application/json',
           },
         ),
       ) {
    final refreshDio = Dio(
      BaseOptions(
        baseUrl: appEnv.apiBaseUrl,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final authRemoteDataSource = AuthRemoteDataSource(
      dio: refreshDio,
      appEnv: appEnv,
    );

    dio.interceptors.addAll([
      AuthInterceptor(
        dio: dio,
        authTokenStorage: authTokenStorage,
        authRemoteDataSource: authRemoteDataSource,
      ),
      LoggerInterceptor(),
    ]);
    refreshDio.interceptors.add(LoggerInterceptor());
  }

  final Dio dio;
}
