import 'package:ryori/features/recipedetail/data/models/responses/recipe_detail_response_dto.dart';

abstract class RecipeDetailRepository {
  Future<RecipeDetailResponseDto> getRecipeDetail(String recipeId);

  Future<void> deleteRecipe(String uuid);
}
