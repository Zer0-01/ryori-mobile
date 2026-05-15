import 'package:injectable/injectable.dart';
import 'package:ryori/features/recipedetail/data/models/responses/recipe_detail_response_dto.dart';
import 'package:ryori/features/recipedetail/domain/repositories/recipe_detail_repository.dart';

@injectable
class GetRecipeDetail {
  final RecipeDetailRepository repository;

  GetRecipeDetail(this.repository);

  Future<RecipeDetailResponseDto> call(String recipeId) => repository.getRecipeDetail(recipeId);
}
