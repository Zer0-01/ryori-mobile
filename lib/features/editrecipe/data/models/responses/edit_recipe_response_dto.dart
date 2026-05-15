import 'package:ryori/core/database/app_database.dart';

class EditRecipeResponseDto {
  final String uuid;
  final String title;
  final String description;
  final String imageUrl;
  final String type;
  final List<String> steps;
  final List<String> ingredients;
  final DateTime createdAt;

  const EditRecipeResponseDto({
    required this.uuid,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.steps,
    required this.ingredients,
    required this.createdAt,
  });

  factory EditRecipeResponseDto.fromRecipeRow(Recipe row) {
    return EditRecipeResponseDto(
      uuid: row.uuid,
      title: row.title,
      description: row.description,
      imageUrl: row.imageUrl,
      type: row.type,
      steps: List<String>.unmodifiable(row.steps),
      ingredients: List<String>.unmodifiable(row.ingredients),
      createdAt: row.createdAt,
    );
  }
}
