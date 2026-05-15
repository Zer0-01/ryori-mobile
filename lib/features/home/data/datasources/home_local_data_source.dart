import 'package:injectable/injectable.dart';
import 'package:ryori/core/database/app_database.dart';
import 'package:ryori/features/home/data/models/responses/recipes_response_dto.dart';

@lazySingleton
class HomeLocalDataSource {
  HomeLocalDataSource(this._database);

  final AppDatabase _database;

  Future<RecipesResponseDto> getRecipes({String? type}) async {
    final query = _database.select(_database.recipes);
    final normalizedType = type?.trim();

    if (normalizedType != null && normalizedType.isNotEmpty) {
      query.where((recipe) => recipe.type.equals(normalizedType));
    }

    final rows = await query.get();
    final recipes = rows.map(RecipeData.fromRecipeRow).toList();

    return RecipesResponseDto(
      data: recipes,
      meta: RecipeMeta(total: recipes.length, limit: recipes.length, page: 1),
    );
  }

  Stream<List<Recipe>> watchRecipes() {
    return _database.select(_database.recipes).watch();
  }

  Future<void> saveRecipe(RecipesCompanion recipe) async {
    await _database.into(_database.recipes).insertOnConflictUpdate(recipe);
  }

  Future<void> saveRecipes(List<RecipesCompanion> recipes) async {
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(_database.recipes, recipes);
    });
  }

  Future<void> clearRecipes() async {
    await _database.delete(_database.recipes).go();
  }
}
