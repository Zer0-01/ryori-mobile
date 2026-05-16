import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/data/auth_remote_data_source.dart';
import 'package:ryori/features/login/data/models/requests/login_request_dto.dart';
import 'package:ryori/features/login/data/models/responses/login_response_dto.dart';
import 'package:ryori/features/login/domain/repositories/login_repository.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) {
    return _authRemoteDataSource.login(request);
  }
}
