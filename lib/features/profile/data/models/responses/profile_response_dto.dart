class ProfileResponseDto {
  const ProfileResponseDto({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  final String id;
  final String email;
  final String? name;
  final DateTime createdAt;

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return ProfileResponseDto(
      id: (json['id'] as String?)?.trim() ?? '',
      email: (json['email'] as String?)?.trim() ?? '',
      name: (json['name'] as String?)?.trim(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
