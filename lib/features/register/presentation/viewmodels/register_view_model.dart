import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/features/register/data/models/requests/register_request_dto.dart';
import 'package:ryori/features/register/data/models/responses/register_response_dto.dart';
import 'package:ryori/features/register/domain/usecases/post_register.dart';

enum PostRegisterStatus { initial, loading, success, failure }

@injectable
class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel(this._postRegister);

  final PostRegister _postRegister;
  final AppLogger _logger = AppLogger(tag: 'RegisterViewModel');

  PostRegisterStatus _postRegisterStatus = PostRegisterStatus.initial;
  PostRegisterStatus get postRegisterStatus => _postRegisterStatus;

  RegisterResponseDto? _registeredUser;
  RegisterResponseDto? get registeredUser => _registeredUser;

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final request = RegisterRequestDto(
        email: _normalizeEmail(email),
        password: _normalizeRequiredText(password, fieldName: 'password'),
        name: _normalizeRequiredText(name, fieldName: 'name'),
      );

      _postRegisterStatus = PostRegisterStatus.loading;
      _registeredUser = null;
      notifyListeners();

      _registeredUser = await _postRegister(request);
      _postRegisterStatus = PostRegisterStatus.success;
      notifyListeners();
      _logger.d('Register success for ${_registeredUser?.email}');
    } catch (error, stackTrace) {
      _registeredUser = null;
      _postRegisterStatus = PostRegisterStatus.failure;
      notifyListeners();
      _logger.e(
        'Register failed.',
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
