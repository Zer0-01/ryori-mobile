import 'package:ryori/features/login/data/models/requests/login_request_dto.dart';
import 'package:ryori/features/login/data/models/responses/login_response_dto.dart';

abstract class LoginRepository {
  Future<LoginResponseDto> login(LoginRequestDto request);
}
