import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStorage {
  AuthTokenStorage(this._secureStorage);

  static const accessTokenKey = 'accesstoken';
  static const refreshTokenKey = 'refreshtoken';

  final FlutterSecureStorage _secureStorage;

  Future<String?> readAccessToken() {
    return _secureStorage.read(key: accessTokenKey);
  }

  Future<String?> readRefreshToken() {
    return _secureStorage.read(key: refreshTokenKey);
  }

  Future<void> writeAccessToken(String token) {
    return _secureStorage.write(key: accessTokenKey, value: token);
  }

  Future<void> writeRefreshToken(String token) {
    return _secureStorage.write(key: refreshTokenKey, value: token);
  }

  Future<bool> hasAccessToken() async {
    final token = await readAccessToken();
    return token != null && token.trim().isNotEmpty;
  }

  Future<bool> isAccessTokenExpired() async {
    final token = await readAccessToken();
    return isTokenExpired(token);
  }

  bool isTokenExpired(String? token) {
    if (token == null || token.trim().isEmpty) {
      return true;
    }

    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return true;
      }

      final normalized = base64Url.normalize(parts[1]);
      final payload = utf8.decode(base64Url.decode(normalized));
      final decoded = jsonDecode(payload);

      if (decoded is! Map<String, dynamic>) {
        return true;
      }

      final exp = decoded['exp'];
      final secondsSinceEpoch = switch (exp) {
        int value => value,
        double value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      };

      if (secondsSinceEpoch == null) {
        return true;
      }

      final expiry = DateTime.fromMillisecondsSinceEpoch(
        secondsSinceEpoch * 1000,
        isUtc: true,
      );

      return !expiry.isAfter(DateTime.now().toUtc());
    } catch (_) {
      return true;
    }
  }
}
