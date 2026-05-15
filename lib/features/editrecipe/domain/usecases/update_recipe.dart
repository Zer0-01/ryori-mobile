import 'package:injectable/injectable.dart';
import 'package:ryori/features/editrecipe/data/models/requests/edit_recipe_request_dto.dart';
import 'package:ryori/features/editrecipe/data/models/responses/edit_recipe_response_dto.dart';
import 'package:ryori/features/editrecipe/domain/repositories/edit_recipe_repository.dart';

@injectable
class UpdateRecipe {
  UpdateRecipe(this.repository);

  final EditRecipeRepository repository;

  Future<EditRecipeResponseDto> call(EditRecipeRequestDto request) =>
      repository.updateRecipe(request);
}
