import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/usecases/get_type.dart';
import 'package:ryori/features/recipes/data/models/responses/recipes_response_dto.dart';
import 'package:ryori/features/recipes/domain/usecases/get_recipes.dart';

enum GetRecipesStatus { initial, loading, success, failure }

enum GetRecipeTypesStatus { initial, loading, success, failure }

@injectable
class RecipesViewModel extends ChangeNotifier {
  RecipesViewModel(this.getRecipes) {
    init();
  }

  final GetRecipes getRecipes;
  final GetType _getType = getIt<GetType>();
  final AppLogger _logger = AppLogger(tag: 'RecipesViewModel');

  GetRecipesStatus _status = GetRecipesStatus.initial;
  GetRecipesStatus get status => _status;

  GetRecipeTypesStatus _getTypesStatus = GetRecipeTypesStatus.initial;
  GetRecipeTypesStatus get getTypesStatus => _getTypesStatus;

  List<RecipeData> _recipes = [];
  List<RecipeData> get recipes => _recipes;

  final List<TypeData> _types = [];
  List<TypeData> get types => _types;

  String? _selectedType;
  String? get selectedType => _selectedType;
  bool get hasActiveTypeFilter =>
      _selectedType != null && _selectedType!.trim().isNotEmpty;

  Future<void> init() async {
    await fetchTypes();
    await fetchRecipes();
  }

  Future<void> fetchTypes() async {
    _getTypesStatus = GetRecipeTypesStatus.loading;
    notifyListeners();

    try {
      final response = await _getType();
      _types
        ..clear()
        ..addAll(response.data);
      _getTypesStatus = GetRecipeTypesStatus.success;
      notifyListeners();
      _logger.d("Fetched ${response.data.length} recipe types");
    } catch (e) {
      _types.clear();
      _getTypesStatus = GetRecipeTypesStatus.failure;
      notifyListeners();
      _logger.e("Error fetching recipe types: $e");
    }
  }

  Future<void> fetchRecipes({String? type}) async {
    _logger.d("Entering fetchRecipes method");
    try {
      _status = GetRecipesStatus.loading;
      _selectedType = _normalizeOptionalType(type);
      notifyListeners();

      final response = await getRecipes(type: _selectedType);
      _recipes = response.data;
      _logger.d("Fetched ${response.meta.total} recipes");
      _status = GetRecipesStatus.success;
      notifyListeners();
    } catch (e) {
      _logger.e("Error fetching recipes: $e");
      _status = GetRecipesStatus.failure;
      notifyListeners();
    }
  }

  Future<void> clearTypeFilter() async {
    await fetchRecipes(type: null);
  }

  String? _normalizeOptionalType(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }

    return normalized;
  }
}
