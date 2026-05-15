import 'package:injectable/injectable.dart';
import 'package:ryori/features/addrecipe/data/models/requests/add_recipe_request_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/add_recipe_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/repositories/add_recipe_repository.dart';

@injectable
class PostRecipe {
  PostRecipe(this.repository);

  final AddRecipeRepository repository;

  Future<AddRecipeResponseDto> call(AddRecipeRequestDto request) =>
      repository.postRecipe(request);
}
