import 'package:dio/dio.dart';
import 'package:ryori/core/auth/models/refresh_token_request_dto.dart';
import 'package:ryori/core/auth/models/refresh_token_response_dto.dart';
import 'package:ryori/core/env/app_env.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required Dio dio,
    required AppEnv appEnv,
  }) : _dio = dio,
       _appEnv = appEnv;

  final Dio _dio;
  final AppEnv _appEnv;

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
