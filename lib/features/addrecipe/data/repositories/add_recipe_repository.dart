import 'package:injectable/injectable.dart';
import 'package:ryori/features/addrecipe/data/datasources/add_recipe_local_data_source.dart';
import 'package:ryori/features/addrecipe/data/models/requests/add_recipe_request_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/add_recipe_response_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/repositories/add_recipe_repository.dart';

@LazySingleton(as: AddRecipeRepository)
class AddRecipeRepositoryImpl implements AddRecipeRepository {
  AddRecipeRepositoryImpl(this.localDataSource);

  final AddRecipeLocalDataSource localDataSource;
  @override
  Future<TypeResponseDto> getTypes() async {
    return await localDataSource.getTypes();
  }

  @override
  Future<AddRecipeResponseDto> postRecipe(AddRecipeRequestDto request) async {
    return await localDataSource.postRecipe(request);
  }
}
