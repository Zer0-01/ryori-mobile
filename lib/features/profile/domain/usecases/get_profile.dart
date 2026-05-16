import 'package:injectable/injectable.dart';
import 'package:ryori/features/profile/data/models/responses/profile_response_dto.dart';
import 'package:ryori/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetProfile {
  const GetProfile(this._profileRepository);

  final ProfileRepository _profileRepository;

  Future<ProfileResponseDto> call() {
    return _profileRepository.getProfile();
  }
}
