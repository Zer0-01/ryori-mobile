import 'package:injectable/injectable.dart';
import 'package:ryori/features/recipedetail/domain/repositories/recipe_detail_repository.dart';

@injectable
class DeleteRecipe {
  DeleteRecipe(this.repository);

  final RecipeDetailRepository repository;

  Future<void> call(String uuid) => repository.deleteRecipe(uuid);
}
