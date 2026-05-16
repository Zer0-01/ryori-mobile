import 'package:injectable/injectable.dart';
import 'package:ryori/features/recipes/data/models/responses/recipes_response_dto.dart';
import 'package:ryori/features/recipes/domain/repositories/recipes_repository.dart';

@injectable
class GetRecipes {
  GetRecipes(this.repository);

  final RecipesRepository repository;

  Future<RecipesResponseDto> call({String? type}) =>
      repository.getRecipes(type: type);
}
