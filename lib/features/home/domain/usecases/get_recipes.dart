import 'package:injectable/injectable.dart';
import 'package:ryori/features/home/data/models/responses/recipes_response_dto.dart';
import 'package:ryori/features/home/domain/repositories/home_repository.dart';

@injectable
class GetRecipes {
  GetRecipes(this.repository);

  final HomeRepository repository;

  Future<RecipesResponseDto> call({String? type}) =>
      repository.getRecipes(type: type);
}
