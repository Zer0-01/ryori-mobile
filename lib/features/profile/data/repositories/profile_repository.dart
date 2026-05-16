import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/data/auth_remote_data_source.dart';
import 'package:ryori/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ryori/features/profile/data/models/responses/logout_response_dto.dart';
import 'package:ryori/features/profile/data/models/responses/profile_response_dto.dart';
import 'package:ryori/features/profile/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._profileRemoteDataSource, this._authRemoteDataSource);

  final ProfileRemoteDataSource _profileRemoteDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<ProfileResponseDto> getProfile() {
    return _profileRemoteDataSource.getProfile();
  }

  @override
  Future<LogoutResponseDto> logout() {
    return _authRemoteDataSource.logout();
  }
}
