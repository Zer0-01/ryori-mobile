class TypeResponseDto {
  final List<TypeData> data;

  TypeResponseDto({required this.data});
}

class TypeData {
  final int id;
  final String name;

  TypeData({required this.id, required this.name});
}
