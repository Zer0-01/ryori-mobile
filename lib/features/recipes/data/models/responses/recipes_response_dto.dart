import 'package:ryori/core/database/app_database.dart';

class RecipesResponseDto {
  final List<RecipeData> data;
  final RecipeMeta meta;

  const RecipesResponseDto({
    required this.data,
    required this.meta,
  });
}

class RecipeData {
  final String uuid;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  const RecipeData({
    required this.uuid,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  factory RecipeData.fromRecipeRow(Recipe row) {
    return RecipeData(
      uuid: row.uuid,
      title: row.title,
      description: row.description,
      imageUrl: row.imageUrl,
      createdAt: row.createdAt,
    );
  }
}

class RecipeMeta {
  final int total;
  final int limit;
  final int page;

  const RecipeMeta({
    required this.total,
    required this.limit,
    required this.page,
  });
}
