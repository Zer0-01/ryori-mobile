import 'package:ryori/features/register/data/models/requests/register_request_dto.dart';
import 'package:ryori/features/register/data/models/responses/register_response_dto.dart';

abstract class RegisterRepository {
  Future<RegisterResponseDto> register(RegisterRequestDto request);
}
