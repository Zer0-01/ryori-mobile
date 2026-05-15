import 'package:ryori/core/database/app_database.dart';

class AddRecipeResponseDto {
  final String uuid;
  final String title;
  final String description;
  final String imageUrl;
  final String type;
  final List<String> steps;
  final List<String> ingredients;
  final DateTime createdAt;

  const AddRecipeResponseDto({
    required this.uuid,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.steps,
    required this.ingredients,
    required this.createdAt,
  });

  factory AddRecipeResponseDto.fromRecipeRow(Recipe row) {
    return AddRecipeResponseDto(
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
