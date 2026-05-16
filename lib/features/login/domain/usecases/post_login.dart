import 'package:injectable/injectable.dart';
import 'package:ryori/features/login/data/models/requests/login_request_dto.dart';
import 'package:ryori/features/login/data/models/responses/login_response_dto.dart';
import 'package:ryori/features/login/domain/repositories/login_repository.dart';

@injectable
class PostLogin {
  const PostLogin(this._loginRepository);

  final LoginRepository _loginRepository;

  Future<LoginResponseDto> call(LoginRequestDto request) {
    return _loginRepository.login(request);
  }
}
