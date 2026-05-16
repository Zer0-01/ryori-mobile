class RefreshTokenResponseDto {
  const RefreshTokenResponseDto({required this.accessToken});

  final String accessToken;

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseDto(
      accessToken: json['accessToken'] as String,
    );
  }
}
