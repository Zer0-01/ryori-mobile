import 'package:injectable/injectable.dart';
import 'package:ryori/core/database/app_database.dart';
import 'package:ryori/features/recipedetail/data/models/responses/recipe_detail_response_dto.dart';

@lazySingleton
class RecipeDetailLocalDataSource {
  RecipeDetailLocalDataSource(this._database);

  final AppDatabase _database;

  Future<RecipeDetailResponseDto> getRecipeDetail(String recipeId) async {
    final recipe =
        await (_database.select(
          _database.recipes,
        )..where((tbl) => tbl.uuid.equals(recipeId))).getSingle();

    return RecipeDetailResponseDto.fromRecipeRow(recipe);
  }

  Future<void> deleteRecipe(String uuid) async {
    await (_database.delete(
      _database.recipes,
    )..where((tbl) => tbl.uuid.equals(uuid))).go();
  }
}
