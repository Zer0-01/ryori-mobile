import 'package:injectable/injectable.dart';
import 'package:ryori/features/recipes/data/datasources/recipes_query_local_data_source.dart';
import 'package:ryori/features/recipes/data/datasources/recipes_remote_data_source.dart';
import 'package:ryori/features/recipes/data/models/responses/recipes_response_dto.dart';
import 'package:ryori/features/recipes/domain/repositories/recipes_repository.dart';

@LazySingleton(as: RecipesRepository)
class RecipesRepositoryImpl implements RecipesRepository {
  RecipesRepositoryImpl(this.remoteDataSource, this.localDataSource);

  final RecipesRemoteDataSource remoteDataSource;
  final RecipesQueryLocalDataSource localDataSource;

  @override
  Future<RecipesResponseDto> getRecipes({String? type}) async {
    return await localDataSource.getRecipes(type: type);
  }
}
