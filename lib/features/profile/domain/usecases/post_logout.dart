import 'package:injectable/injectable.dart';
import 'package:ryori/features/profile/data/models/responses/logout_response_dto.dart';
import 'package:ryori/features/profile/domain/repositories/profile_repository.dart';

@injectable
class PostLogout {
  const PostLogout(this._profileRepository);

  final ProfileRepository _profileRepository;

  Future<LogoutResponseDto> call() {
    return _profileRepository.logout();
  }
}
