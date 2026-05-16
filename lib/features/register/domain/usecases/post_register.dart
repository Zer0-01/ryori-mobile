import 'package:injectable/injectable.dart';
import 'package:ryori/features/register/data/models/requests/register_request_dto.dart';
import 'package:ryori/features/register/data/models/responses/register_response_dto.dart';
import 'package:ryori/features/register/domain/repositories/register_repository.dart';

@injectable
class PostRegister {
  const PostRegister(this._registerRepository);

  final RegisterRepository _registerRepository;

  Future<RegisterResponseDto> call(RegisterRequestDto request) {
    return _registerRepository.register(request);
  }
}
