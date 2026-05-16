import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/models/refresh_token_request_dto.dart';
import 'package:ryori/core/auth/models/refresh_token_response_dto.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/features/login/data/models/requests/login_request_dto.dart';
import 'package:ryori/features/login/data/models/responses/login_response_dto.dart';
import 'package:ryori/features/register/data/models/requests/register_request_dto.dart';
import 'package:ryori/features/register/data/models/responses/register_response_dto.dart';

@lazySingleton
class AuthRemoteDataSource {
  AuthRemoteDataSource({
    @Named('authDio') required Dio dio,
    required AppEnv appEnv,
  }) : _dio = dio,
       _appEnv = appEnv;

  final Dio _dio;
  final AppEnv _appEnv;

  Future<LoginResponseDto> login(LoginRequestDto request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _appEnv.authLoginEndpoint,
      data: request.toJson(),
      options: Options(
        extra: const {
          'requiresAuth': false,
        },
      ),
    );

    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Login response body is empty.',
      );
    }

    return LoginResponseDto.fromJson(data);
  }

  Future<RegisterResponseDto> register(RegisterRequestDto request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _appEnv.authRegisterEndpoint,
      data: request.toJson(),
      options: Options(
        extra: const {
          'requiresAuth': false,
        },
      ),
    );

    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Register response body is empty.',
      );
    }

    return RegisterResponseDto.fromJson(data);
  }

  Future<RefreshTokenResponseDto> refreshAccessToken({
    required String refreshToken,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _appEnv.authRefreshEndpoint,
      data: RefreshTokenRequestDto(refreshToken: refreshToken).toJson(),
      options: Options(
        extra: const {
          'requiresAuth': false,
        },
      ),
    );

    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Refresh response body is empty.',
      );
    }

    return RefreshTokenResponseDto.fromJson(data);
  }
}
