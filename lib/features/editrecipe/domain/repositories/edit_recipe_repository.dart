import 'package:ryori/features/editrecipe/data/models/requests/edit_recipe_request_dto.dart';
import 'package:ryori/features/editrecipe/data/models/responses/edit_recipe_response_dto.dart';

abstract class EditRecipeRepository {
  Future<EditRecipeResponseDto> updateRecipe(EditRecipeRequestDto request);
}
