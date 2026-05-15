class EditRecipeRequestDto {
  final String uuid;
  final String name;
  final String description;
  final String imageUrl;
  final String type;
  final List<String> steps;
  final List<String> ingredients;
  final DateTime createdAt;

  EditRecipeRequestDto({
    required this.uuid,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.steps,
    required this.ingredients,
    required this.createdAt,
  });
}
