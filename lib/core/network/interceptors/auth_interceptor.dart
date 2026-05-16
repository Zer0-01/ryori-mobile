import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ryori/core/auth/auth_session_expired_exception.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';
import 'package:ryori/core/auth/data/auth_remote_data_source.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required Dio dio,
    required AuthTokenStorage authTokenStorage,
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _dio = dio,
       _authTokenStorage = authTokenStorage,
       _authRemoteDataSource = authRemoteDataSource;

  static const requiresAuthKey = 'requiresAuth';
  static const retryAttemptedKey = 'authRetryAttempted';

  final Dio _dio;
  final AuthTokenStorage _authTokenStorage;
  final AuthRemoteDataSource _authRemoteDataSource;

  Future<String>? _refreshingTokenFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_requiresAuth(options)) {
      handler.next(options);
      return;
    }

    try {
      final accessToken = await _authTokenStorage.readAccessToken();
      if (accessToken == null || accessToken.trim().isEmpty) {
        handler.next(options);
        return;
      }

      if (_authTokenStorage.isTokenExpired(accessToken)) {
        final refreshedToken = await _refreshAccessToken();
        _attachBearer(options, refreshedToken);
        handler.next(options);
        return;
      }

      _attachBearer(options, accessToken);
      handler.next(options);
    } catch (error) {
      if (error is DioException) {
        handler.reject(error);
        return;
      }

      if (error is AuthSessionExpiredException) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: error,
          ),
        );
        return;
      }

      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
        ),
      );
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    if (statusCode != 401 ||
        !_requiresAuth(requestOptions) ||
        requestOptions.extra[retryAttemptedKey] == true) {
      handler.next(err);
      return;
    }

    try {
      final refreshedToken = await _refreshAccessToken();
      final retryOptions = requestOptions.copyWith(
        headers: Map<String, dynamic>.from(requestOptions.headers),
        extra: Map<String, dynamic>.from(requestOptions.extra)
          ..[retryAttemptedKey] = true,
      );
      _attachBearer(retryOptions, refreshedToken);

      final response = await _dio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } catch (error) {
      if (error is DioException) {
        handler.reject(error);
        return;
      }

      if (error is AuthSessionExpiredException) {
        handler.reject(
          DioException(
            requestOptions: requestOptions,
            response: err.response,
            error: error,
          ),
        );
        return;
      }

      handler.reject(
        DioException(
          requestOptions: requestOptions,
          error: error,
        ),
      );
    }
  }

  bool _requiresAuth(RequestOptions options) {
    return options.extra[requiresAuthKey] != false;
  }

  void _attachBearer(RequestOptions options, String accessToken) {
    options.headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<String> _refreshAccessToken() async {
    final inFlightRefresh = _refreshingTokenFuture;
    if (inFlightRefresh != null) {
      return inFlightRefresh;
    }

    final refreshFuture = _performRefresh();
    _refreshingTokenFuture = refreshFuture;

    try {
      return await refreshFuture;
    } finally {
      if (identical(_refreshingTokenFuture, refreshFuture)) {
        _refreshingTokenFuture = null;
      }
    }
  }

  Future<String> _performRefresh() async {
    final refreshToken = await _authTokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.trim().isEmpty) {
      throw const AuthSessionExpiredException(
        'Refresh token is missing. Please login again.',
      );
    }

    try {
      final response = await _authRemoteDataSource.refreshAccessToken(
        refreshToken: refreshToken,
      );
      await _authTokenStorage.writeAccessToken(response.accessToken);
      return response.accessToken;
    } on DioException catch (error) {
      throw AuthSessionExpiredException(
        error.response?.data is Map<String, dynamic>
            ? (error.response?.data as Map<String, dynamic>)['message']
                    as String? ??
                'Unable to refresh your session. Please login again.'
            : 'Unable to refresh your session. Please login again.',
      );
    }
  }
}
