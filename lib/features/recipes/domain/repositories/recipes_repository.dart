import 'package:ryori/features/recipes/data/models/responses/recipes_response_dto.dart';

abstract class RecipesRepository {
  Future<RecipesResponseDto> getRecipes({String? type});
}
