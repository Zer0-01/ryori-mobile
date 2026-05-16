import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/auth_session_expired_exception.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/features/profile/data/models/responses/logout_response_dto.dart';
import 'package:ryori/features/profile/data/models/responses/profile_response_dto.dart';
import 'package:ryori/features/profile/domain/usecases/get_profile.dart';
import 'package:ryori/features/profile/domain/usecases/post_logout.dart';

enum GetProfileStatus { initial, loading, success, failure }

enum PostLogoutStatus { initial, loading, success, failure }

@injectable
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._getProfile, this._postLogout, this._authTokenStorage) {
    init();
  }

  final GetProfile _getProfile;
  final PostLogout _postLogout;
  final AuthTokenStorage _authTokenStorage;
  final AppLogger _logger = AppLogger(tag: 'ProfileViewModel');

  GetProfileStatus _getProfileStatus = GetProfileStatus.initial;
  GetProfileStatus get getProfileStatus => _getProfileStatus;

  PostLogoutStatus _postLogoutStatus = PostLogoutStatus.initial;
  PostLogoutStatus get postLogoutStatus => _postLogoutStatus;

  ProfileResponseDto? _profile;
  ProfileResponseDto? get profile => _profile;

  LogoutResponseDto? _logoutResponse;
  LogoutResponseDto? get logoutResponse => _logoutResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthError = false;
  bool get isAuthError => _isAuthError;

  Future<void> init() async {
    await fetchProfile();
  }

  Future<void> fetchProfile() async {
    _getProfileStatus = GetProfileStatus.loading;
    _errorMessage = null;
    _isAuthError = false;
    notifyListeners();

    try {
      final response = await _getProfile();
      _profile = response;
      _getProfileStatus = GetProfileStatus.success;
      notifyListeners();
      _logger.d('Fetched profile for ${response.email}');
    } catch (error, stackTrace) {
      await _handleFailure(
        error: error,
        stackTrace: stackTrace,
        onStatusChanged: () {
          _profile = null;
          _getProfileStatus = GetProfileStatus.failure;
        },
        defaultMessage:
            'An error occurred while loading your profile. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    _postLogoutStatus = PostLogoutStatus.loading;
    _errorMessage = null;
    _isAuthError = false;
    _logoutResponse = null;
    notifyListeners();

    try {
      final response = await _postLogout();
      await _authTokenStorage.clearAuthData();
      _logoutResponse = response;
      _postLogoutStatus = PostLogoutStatus.success;
      notifyListeners();
      _logger.d('Logout success.');
    } catch (error, stackTrace) {
      await _handleFailure(
        error: error,
        stackTrace: stackTrace,
        onStatusChanged: () {
          _postLogoutStatus = PostLogoutStatus.failure;
        },
        defaultMessage: 'An error occurred while logging out. Please try again.',
      );
    }
  }

  Future<void> _handleFailure({
    required Object error,
    required StackTrace stackTrace,
    required VoidCallback onStatusChanged,
    required String defaultMessage,
  }) async {
    _logoutResponse = null;
    _isAuthError = _matchesAuthError(error);
    _errorMessage = _resolveErrorMessage(error, fallback: defaultMessage);

    if (_isAuthError) {
      await _authTokenStorage.clearAuthData();
    }

    onStatusChanged();
    notifyListeners();
    _logger.e(
      _isAuthError ? 'Authentication failure in profile flow.' : defaultMessage,
      error: error,
      stackTrace: stackTrace,
    );
  }

  bool _matchesAuthError(Object error) {
    if (error is AuthSessionExpiredException) {
      return true;
    }

    return error is DioException && error.error is AuthSessionExpiredException;
  }

  String _resolveErrorMessage(Object error, {required String fallback}) {
    if (error is AuthSessionExpiredException) {
      return error.message;
    }

    if (error is DioException) {
      if (error.error case final AuthSessionExpiredException authError) {
        return authError.message;
      }

      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message.trim();
        }
      }
    }

    return fallback;
  }
}
