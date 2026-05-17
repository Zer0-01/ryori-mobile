import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/usecases/get_type.dart';
import 'package:ryori/features/recipedetail/data/models/responses/recipe_detail_response_dto.dart';
import 'package:ryori/features/recipedetail/domain/usecases/delete_recipe.dart';
import 'package:ryori/features/recipedetail/domain/usecases/get_recipe_detail.dart';

enum GetRecipeDetailStatus { initial, loading, success, failure }
enum DeleteRecipeStatus { initial, loading, success, failure }

@injectable
class RecipeDetailViewModel extends ChangeNotifier {
  final GetRecipeDetail getRecipeDetail;
  final DeleteRecipe deleteRecipeUseCase;
  final GetType _getType = getIt<GetType>();
  final AppLogger _logger = AppLogger(tag: 'RecipeDetailViewModel');
  final String recipeId;

  GetRecipeDetailStatus _getRecipeDetailStatus = GetRecipeDetailStatus.initial;
  GetRecipeDetailStatus get getRecipeDetailStatus => _getRecipeDetailStatus;

  DeleteRecipeStatus _deleteRecipeStatus = DeleteRecipeStatus.initial;
  DeleteRecipeStatus get deleteRecipeStatus => _deleteRecipeStatus;

  RecipeDetailResponseDto? _recipeDetail;
  RecipeDetailResponseDto? get recipeDetail => _recipeDetail;

  final List<TypeData> _types = [];

  String get resolvedRecipeId => _recipeDetail?.uuid ?? recipeId;

  RecipeDetailViewModel(
    this.getRecipeDetail,
    this.deleteRecipeUseCase,
    @factoryParam this.recipeId,
  ) {
    init();
  }

  Future<void> init() async {
    await Future.wait([fetchRecipeDetail(recipeId), _fetchTypes()]);
  }

  Future<void> fetchRecipeDetail(String recipeId) async {
    try {
      _logger.d("Fetching recipe detail for ID: $recipeId");
      _getRecipeDetailStatus = GetRecipeDetailStatus.loading;
      notifyListeners();
      _recipeDetail = await getRecipeDetail(recipeId);
      _getRecipeDetailStatus = GetRecipeDetailStatus.success;
      notifyListeners();
      _logger.d("Successfully fetched recipe detail for ID: $recipeId");
    } catch (e) {
      _getRecipeDetailStatus = GetRecipeDetailStatus.failure;
      notifyListeners();
      _logger.e("Error fetching recipe detail for ID: $recipeId - $e");
    }
  }

  Future<bool> deleteRecipe() async {
    final uuid = _recipeDetail?.uuid ?? recipeId;

    try {
      _logger.d("Deleting recipe for ID: $uuid");
      _deleteRecipeStatus = DeleteRecipeStatus.loading;
      notifyListeners();

      await deleteRecipeUseCase(uuid);

      _deleteRecipeStatus = DeleteRecipeStatus.success;
      notifyListeners();
      _logger.d("Successfully deleted recipe for ID: $uuid");
      return true;
    } catch (e) {
      _deleteRecipeStatus = DeleteRecipeStatus.failure;
      notifyListeners();
      _logger.e("Error deleting recipe for ID: $uuid - $e");
      return false;
    }
  }

  String? resolveTypeBadgeColor(String typeName) {
    final normalizedTypeName = typeName.trim().toLowerCase();

    for (final type in _types) {
      if (type.name.trim().toLowerCase() == normalizedTypeName) {
        return type.badgeColor;
      }
    }

    return null;
  }

  Future<void> _fetchTypes() async {
    try {
      final response = await _getType();
      _types
        ..clear()
        ..addAll(response.data);
      _logger.d('Fetched ${response.data.length} recipe types for detail.');
    } catch (e) {
      _types.clear();
      _logger.e('Error fetching recipe types for detail: $e');
    }
  }
}
