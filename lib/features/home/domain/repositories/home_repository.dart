import 'package:ryori/features/home/data/models/responses/recipes_response_dto.dart';

abstract class HomeRepository {
  Future<RecipesResponseDto> getRecipes({String? type});
}
