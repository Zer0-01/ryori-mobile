import 'package:injectable/injectable.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/repositories/add_recipe_repository.dart';

@injectable
class GetType {
  GetType(this.repository);

  final AddRecipeRepository repository;

  Future<TypeResponseDto> call() => repository.getTypes();
}
