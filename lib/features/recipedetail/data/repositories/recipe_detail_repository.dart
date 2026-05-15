import 'package:injectable/injectable.dart';
import 'package:ryori/features/recipedetail/data/datasources/recipe_detail_local_data_source.dart';
import 'package:ryori/features/recipedetail/data/models/responses/recipe_detail_response_dto.dart';
import 'package:ryori/features/recipedetail/domain/repositories/recipe_detail_repository.dart';

@LazySingleton(as: RecipeDetailRepository)
class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  RecipeDetailRepositoryImpl(this.localDataSource);

  final RecipeDetailLocalDataSource localDataSource;

  @override
  Future<RecipeDetailResponseDto> getRecipeDetail(String recipeId) =>
      localDataSource.getRecipeDetail(recipeId);

  @override
  Future<void> deleteRecipe(String uuid) => localDataSource.deleteRecipe(uuid);
}
