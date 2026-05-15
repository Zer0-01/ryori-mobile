import 'package:injectable/injectable.dart';
import 'package:ryori/core/database/app_database.dart';
import 'package:ryori/features/editrecipe/data/models/requests/edit_recipe_request_dto.dart';
import 'package:ryori/features/editrecipe/data/models/responses/edit_recipe_response_dto.dart';

@lazySingleton
class EditRecipeLocalDataSource {
  EditRecipeLocalDataSource(this._database);

  final AppDatabase _database;

  Future<EditRecipeResponseDto> updateRecipe(EditRecipeRequestDto request) async {
    await _database.into(_database.recipes).insertOnConflictUpdate(
      RecipesCompanion.insert(
        uuid: request.uuid,
        title: request.name,
        description: request.description,
        imageUrl: request.imageUrl,
        type: request.type,
        steps: request.steps,
        ingredients: request.ingredients,
        createdAt: request.createdAt,
      ),
    );

    final updatedRecipe =
        await (_database.select(
          _database.recipes,
        )..where((recipe) => recipe.uuid.equals(request.uuid))).getSingle();

    return EditRecipeResponseDto.fromRecipeRow(updatedRecipe);
  }
}
