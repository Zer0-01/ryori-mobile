import 'package:injectable/injectable.dart';
import 'package:ryori/features/editrecipe/data/datasources/edit_recipe_local_data_source.dart';
import 'package:ryori/features/editrecipe/data/models/requests/edit_recipe_request_dto.dart';
import 'package:ryori/features/editrecipe/data/models/responses/edit_recipe_response_dto.dart';
import 'package:ryori/features/editrecipe/domain/repositories/edit_recipe_repository.dart';

@LazySingleton(as: EditRecipeRepository)
class EditRecipeRepositoryImpl implements EditRecipeRepository {
  EditRecipeRepositoryImpl(this.localDataSource);

  final EditRecipeLocalDataSource localDataSource;

  @override
  Future<EditRecipeResponseDto> updateRecipe(EditRecipeRequestDto request) async {
    return await localDataSource.updateRecipe(request);
  }
}
