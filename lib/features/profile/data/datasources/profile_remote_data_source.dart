import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/env/app_env.dart';
import 'package:ryori/features/profile/data/models/responses/profile_response_dto.dart';

@lazySingleton
class ProfileRemoteDataSource {
  ProfileRemoteDataSource({
    @Named('apiDio') required Dio dio,
    required AppEnv appEnv,
  }) : _dio = dio,
       _appEnv = appEnv;

  final Dio _dio;
  final AppEnv _appEnv;

  Future<ProfileResponseDto> getProfile() async {
    final response = await _dio.get<Map<String, dynamic>>(
      _appEnv.profileEndpoint,
    );
    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Profile response body is empty.',
      );
    }

    return ProfileResponseDto.fromJson(data);
  }
}
