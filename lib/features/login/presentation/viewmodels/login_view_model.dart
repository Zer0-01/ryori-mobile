import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/features/login/data/models/requests/login_request_dto.dart';
import 'package:ryori/features/login/data/models/responses/login_response_dto.dart';
import 'package:ryori/features/login/domain/usecases/post_login.dart';

enum PostLoginStatus { initial, loading, success, failure }

@injectable
class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._postLogin, this._authTokenStorage);

  final PostLogin _postLogin;
  final AuthTokenStorage _authTokenStorage;
  final AppLogger _logger = AppLogger(tag: 'LoginViewModel');

  PostLoginStatus _postLoginStatus = PostLoginStatus.initial;
  PostLoginStatus get postLoginStatus => _postLoginStatus;

  LoginResponseDto? _loggedInUser;
  LoginResponseDto? get loggedInUser => _loggedInUser;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequestDto(
        email: _normalizeEmail(email),
        password: _normalizeRequiredText(password, fieldName: 'password'),
      );

      _postLoginStatus = PostLoginStatus.loading;
      _loggedInUser = null;
      notifyListeners();

      final response = await _postLogin(request);
      await _authTokenStorage.writeAccessToken(response.accessToken);
      await _authTokenStorage.writeRefreshToken(response.refreshToken);

      _loggedInUser = response;
      _postLoginStatus = PostLoginStatus.success;
      notifyListeners();
      _logger.d('Login success for ${response.user.email}');
    } catch (error, stackTrace) {
      _loggedInUser = null;
      _postLoginStatus = PostLoginStatus.failure;
      notifyListeners();
      _logger.e(
        'Login failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _normalizeEmail(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized.isEmpty) {
      throw ArgumentError.value(value, 'email', 'email cannot be empty.');
    }

    return normalized;
  }

  String _normalizeRequiredText(String value, {required String fieldName}) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(
        value,
        fieldName,
        '$fieldName cannot be empty.',
      );
    }

    return normalized;
  }
}
