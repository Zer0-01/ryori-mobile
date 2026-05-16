class LogoutResponseDto {
  const LogoutResponseDto({required this.message});

  final String message;

  factory LogoutResponseDto.fromJson(Map<String, dynamic> json) {
    return LogoutResponseDto(
      message: (json['message'] as String?)?.trim().isNotEmpty == true
          ? (json['message'] as String).trim()
          : 'Logout successful.',
    );
  }
}
