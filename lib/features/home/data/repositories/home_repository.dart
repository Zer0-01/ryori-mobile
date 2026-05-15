import 'package:injectable/injectable.dart';
import 'package:ryori/features/home/data/datasources/home_local_data_source.dart';
import 'package:ryori/features/home/data/models/responses/recipes_response_dto.dart';
import 'package:ryori/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ryori/features/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.remoteDataSource, this.localDataSource);

  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  @override
  Future<RecipesResponseDto> getRecipes({String? type}) async {
    return await localDataSource.getRecipes(type: type);
  }
}
