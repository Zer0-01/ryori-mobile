class AuthSessionExpiredException implements Exception {
  const AuthSessionExpiredException([
    this.message = 'Your session has expired. Please login again.',
  ]);

  final String message;

  @override
  String toString() => 'AuthSessionExpiredException: $message';
}
