class LoginResponseDto {
  const LoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final LoginResponseUserDto user;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: LoginResponseUserDto.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class LoginResponseUserDto {
  const LoginResponseUserDto({
    required this.id,
    required this.email,
    required this.name,
  });

  final String id;
  final String email;
  final String name;

  factory LoginResponseUserDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseUserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }
}
