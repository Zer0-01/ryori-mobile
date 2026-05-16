import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/data/auth_remote_data_source.dart';
import 'package:ryori/features/register/data/models/requests/register_request_dto.dart';
import 'package:ryori/features/register/data/models/responses/register_response_dto.dart';
import 'package:ryori/features/register/domain/repositories/register_repository.dart';

@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<RegisterResponseDto> register(RegisterRequestDto request) {
    return _authRemoteDataSource.register(request);
  }
}
