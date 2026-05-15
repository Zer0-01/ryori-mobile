// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ryori/core/database/app_database.dart' as _i1070;
import 'package:ryori/core/utils/picker_service.dart' as _i610;
import 'package:ryori/features/addrecipe/data/datasources/add_recipe_local_data_source.dart'
    as _i918;
import 'package:ryori/features/addrecipe/data/repositories/add_recipe_repository.dart'
    as _i564;
import 'package:ryori/features/addrecipe/domain/repositories/add_recipe_repository.dart'
    as _i7;
import 'package:ryori/features/addrecipe/domain/usecases/get_type.dart'
    as _i228;
import 'package:ryori/features/addrecipe/domain/usecases/post_recipe.dart'
    as _i535;
import 'package:ryori/features/addrecipe/presentation/viewmodels/add_recipe_view_model.dart'
    as _i193;
import 'package:ryori/features/editrecipe/data/datasources/edit_recipe_local_data_source.dart'
    as _i0;
import 'package:ryori/features/editrecipe/data/repositories/edit_recipe_repository.dart'
    as _i4;
import 'package:ryori/features/editrecipe/domain/repositories/edit_recipe_repository.dart'
    as _i691;
import 'package:ryori/features/editrecipe/domain/usecases/update_recipe.dart'
    as _i726;
import 'package:ryori/features/editrecipe/presentation/viewmodels/edit_recipe_view_model.dart'
    as _i349;
import 'package:ryori/features/home/data/datasources/home_local_data_source.dart'
    as _i873;
import 'package:ryori/features/home/data/datasources/home_remote_data_source.dart'
    as _i645;
import 'package:ryori/features/home/data/repositories/home_repository.dart'
    as _i271;
import 'package:ryori/features/home/domain/repositories/home_repository.dart'
    as _i596;
import 'package:ryori/features/home/domain/usecases/get_recipes.dart' as _i309;
import 'package:ryori/features/home/presentation/viewmodels/home_view_model.dart'
    as _i262;
import 'package:ryori/features/recipedetail/data/datasources/recipe_detail_local_data_source.dart'
    as _i394;
import 'package:ryori/features/recipedetail/data/repositories/recipe_detail_repository.dart'
    as _i358;
import 'package:ryori/features/recipedetail/domain/repositories/recipe_detail_repository.dart'
    as _i139;
import 'package:ryori/features/recipedetail/domain/usecases/delete_recipe.dart'
    as _i19;
import 'package:ryori/features/recipedetail/domain/usecases/get_recipe_detail.dart'
    as _i810;
import 'package:ryori/features/recipedetail/presentation/viewmodels/recipe_detail_view_model.dart'
    as _i418;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1070.AppDatabase>(() => _i1070.AppDatabase());
    gh.lazySingleton<_i610.PickerService>(() => _i610.PickerService());
    gh.lazySingleton<_i645.HomeRemoteDataSource>(
      () => _i645.HomeRemoteDataSource(),
    );
    gh.lazySingleton<_i918.AddRecipeLocalDataSource>(
      () => _i918.AddRecipeLocalDataSource(gh<_i1070.AppDatabase>()),
    );
    gh.lazySingleton<_i0.EditRecipeLocalDataSource>(
      () => _i0.EditRecipeLocalDataSource(gh<_i1070.AppDatabase>()),
    );
    gh.lazySingleton<_i873.HomeLocalDataSource>(
      () => _i873.HomeLocalDataSource(gh<_i1070.AppDatabase>()),
    );
    gh.lazySingleton<_i394.RecipeDetailLocalDataSource>(
      () => _i394.RecipeDetailLocalDataSource(gh<_i1070.AppDatabase>()),
    );
    gh.lazySingleton<_i691.EditRecipeRepository>(
      () => _i4.EditRecipeRepositoryImpl(gh<_i0.EditRecipeLocalDataSource>()),
    );
    gh.lazySingleton<_i596.HomeRepository>(
      () => _i271.HomeRepositoryImpl(
        gh<_i645.HomeRemoteDataSource>(),
        gh<_i873.HomeLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i139.RecipeDetailRepository>(
      () => _i358.RecipeDetailRepositoryImpl(
        gh<_i394.RecipeDetailLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i7.AddRecipeRepository>(
      () => _i564.AddRecipeRepositoryImpl(gh<_i918.AddRecipeLocalDataSource>()),
    );
    gh.factory<_i309.GetRecipes>(
      () => _i309.GetRecipes(gh<_i596.HomeRepository>()),
    );
    gh.factory<_i726.UpdateRecipe>(
      () => _i726.UpdateRecipe(gh<_i691.EditRecipeRepository>()),
    );
    gh.factory<_i19.DeleteRecipe>(
      () => _i19.DeleteRecipe(gh<_i139.RecipeDetailRepository>()),
    );
    gh.factory<_i810.GetRecipeDetail>(
      () => _i810.GetRecipeDetail(gh<_i139.RecipeDetailRepository>()),
    );
    gh.factoryParam<_i418.RecipeDetailViewModel, String, dynamic>(
      (recipeId, _) => _i418.RecipeDetailViewModel(
        gh<_i810.GetRecipeDetail>(),
        gh<_i19.DeleteRecipe>(),
        recipeId,
      ),
    );
    gh.factory<_i228.GetType>(
      () => _i228.GetType(gh<_i7.AddRecipeRepository>()),
    );
    gh.factory<_i535.PostRecipe>(
      () => _i535.PostRecipe(gh<_i7.AddRecipeRepository>()),
    );
    gh.factory<_i262.HomeViewModel>(
      () => _i262.HomeViewModel(gh<_i309.GetRecipes>()),
    );
    gh.factory<_i193.AddRecipeViewModel>(
      () => _i193.AddRecipeViewModel(
        gh<_i228.GetType>(),
        gh<_i535.PostRecipe>(),
        gh<_i610.PickerService>(),
      ),
    );
    gh.factoryParam<_i349.EditRecipeViewModel, String, dynamic>(
      (recipeId, _) => _i349.EditRecipeViewModel(
        gh<_i810.GetRecipeDetail>(),
        gh<_i228.GetType>(),
        gh<_i726.UpdateRecipe>(),
        gh<_i610.PickerService>(),
        recipeId,
      ),
    );
    return this;
  }
}
