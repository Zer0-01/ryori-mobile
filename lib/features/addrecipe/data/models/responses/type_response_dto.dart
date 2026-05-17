class TypeResponseDto {
  final List<TypeData> data;

  TypeResponseDto({required this.data});
}

class TypeData {
  final int id;
  final String name;
  final String badgeColor;

  TypeData({
    required this.id,
    required this.name,
    required this.badgeColor,
  });
}
