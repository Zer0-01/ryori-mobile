import 'package:ryori/features/profile/data/models/responses/logout_response_dto.dart';
import 'package:ryori/features/profile/data/models/responses/profile_response_dto.dart';

abstract class ProfileRepository {
  Future<ProfileResponseDto> getProfile();
  Future<LogoutResponseDto> logout();
}
