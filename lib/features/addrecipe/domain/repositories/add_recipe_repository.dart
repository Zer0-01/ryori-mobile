import 'package:ryori/features/addrecipe/data/models/requests/add_recipe_request_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/add_recipe_response_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';

abstract class AddRecipeRepository {
  Future<TypeResponseDto> getTypes();

  Future<AddRecipeResponseDto> postRecipe(AddRecipeRequestDto request);
}
