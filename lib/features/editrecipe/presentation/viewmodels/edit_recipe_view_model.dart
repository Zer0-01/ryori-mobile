import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/core/utils/picker_service.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/usecases/get_type.dart';
import 'package:ryori/features/editrecipe/data/models/requests/edit_recipe_request_dto.dart';
import 'package:ryori/features/editrecipe/data/models/responses/edit_recipe_response_dto.dart';
import 'package:ryori/features/editrecipe/domain/usecases/update_recipe.dart';
import 'package:ryori/features/recipedetail/data/models/responses/recipe_detail_response_dto.dart';
import 'package:ryori/features/recipedetail/domain/usecases/get_recipe_detail.dart';

enum EditRecipeLoadStatus { initial, loading, success, failure }

enum UpdateRecipeStatus { initial, loading, success, failure }

enum EditMediaPickerStatus { initial, loading, success, failure }

@injectable
class EditRecipeViewModel extends ChangeNotifier {
  EditRecipeViewModel(
    this.getRecipeDetail,
    this.getType,
    this.updateRecipe,
    this.pickerService,
    @factoryParam this.recipeId,
  ) {
    init();
  }

  final GetRecipeDetail getRecipeDetail;
  final GetType getType;
  final UpdateRecipe updateRecipe;
  final PickerService pickerService;
  final String recipeId;

  final AppLogger _logger = AppLogger(tag: 'EditRecipeViewModel');

  EditRecipeLoadStatus _recipeDetailStatus = EditRecipeLoadStatus.initial;
  EditRecipeLoadStatus get recipeDetailStatus => _recipeDetailStatus;

  EditRecipeLoadStatus _getTypesStatus = EditRecipeLoadStatus.initial;
  EditRecipeLoadStatus get getTypesStatus => _getTypesStatus;

  UpdateRecipeStatus _updateRecipeStatus = UpdateRecipeStatus.initial;
  UpdateRecipeStatus get updateRecipeStatus => _updateRecipeStatus;

  EditMediaPickerStatus _mediaPickerStatus = EditMediaPickerStatus.initial;
  EditMediaPickerStatus get mediaPickerStatus => _mediaPickerStatus;

  RecipeDetailResponseDto? _recipeDetail;
  RecipeDetailResponseDto? get recipeDetail => _recipeDetail;

  EditRecipeResponseDto? _updatedRecipe;
  EditRecipeResponseDto? get updatedRecipe => _updatedRecipe;

  final List<TypeData> _types = [];
  List<TypeData> get types => _types;

  String? _selectedMediaName;
  String? get selectedMediaName => _selectedMediaName;

  String? _selectedMediaPath;
  String? get selectedMediaPath => _selectedMediaPath;

  String? _mediaPickerErrorMessage;
  String? get mediaPickerErrorMessage => _mediaPickerErrorMessage;

  bool get hasSelectedMedia =>
      (_selectedMediaPath?.trim().isNotEmpty ?? false) &&
      (_selectedMediaName?.trim().isNotEmpty ?? false);

  bool get isSelectedMediaImage {
    final path = _selectedMediaPath;
    if (path == null || path.trim().isEmpty) {
      return false;
    }

    const imageExtensions = {
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.bmp',
      '.webp',
      '.heic',
      '.heif',
    };

    final normalizedPath = path.toLowerCase();
    return imageExtensions.any(normalizedPath.endsWith);
  }

  bool get isInitialDataReady =>
      _recipeDetailStatus == EditRecipeLoadStatus.success &&
      _getTypesStatus == EditRecipeLoadStatus.success &&
      _recipeDetail != null;

  Future<void> init() async {
    await Future.wait([fetchRecipeDetail(), fetchTypes()]);
  }

  Future<void> fetchRecipeDetail() async {
    try {
      _recipeDetailStatus = EditRecipeLoadStatus.loading;
      notifyListeners();

      _logger.d('Fetching recipe detail for edit. ID: $recipeId');
      final recipe = await getRecipeDetail(recipeId);
      _recipeDetail = recipe;
      _selectedMediaName = _extractMediaName(recipe.imageUrl);
      _selectedMediaPath = recipe.imageUrl;
      _recipeDetailStatus = EditRecipeLoadStatus.success;
      notifyListeners();
    } catch (e) {
      _recipeDetailStatus = EditRecipeLoadStatus.failure;
      notifyListeners();
      _logger.e('Error fetching recipe detail for edit. ID: $recipeId - $e');
    }
  }

  Future<void> fetchTypes() async {
    _getTypesStatus = EditRecipeLoadStatus.loading;
    notifyListeners();

    try {
      final types = await getType();
      _types
        ..clear()
        ..addAll(types.data);
      _getTypesStatus = EditRecipeLoadStatus.success;
      notifyListeners();
      _logger.d('Fetched ${types.data.length} recipe types for edit.');
    } catch (e) {
      _types.clear();
      _getTypesStatus = EditRecipeLoadStatus.failure;
      notifyListeners();
      _logger.e('Error fetching recipe types for edit: $e');
    }
  }

  Future<void> pickFromGallery() async {
    _mediaPickerStatus = EditMediaPickerStatus.loading;
    _mediaPickerErrorMessage = null;
    notifyListeners();

    try {
      final selectedImage = await pickerService.pickImageFromGallery();
      if (selectedImage == null) {
        _mediaPickerStatus = EditMediaPickerStatus.success;
        notifyListeners();
        return;
      }

      _selectedMediaName = selectedImage.name;
      _selectedMediaPath = selectedImage.path;
      _mediaPickerStatus = EditMediaPickerStatus.success;
      notifyListeners();
    } catch (error, stackTrace) {
      _logger.e(
        'Error picking media from gallery for edit.',
        error: error,
        stackTrace: stackTrace,
      );
      _mediaPickerStatus = EditMediaPickerStatus.failure;
      _mediaPickerErrorMessage =
          'An error occurred while picking the image. Please try again.';
      notifyListeners();
    }
  }

  Future<void> pickFromFile() async {
    _mediaPickerStatus = EditMediaPickerStatus.loading;
    _mediaPickerErrorMessage = null;
    notifyListeners();

    try {
      final selectedFiles = await pickerService.pickFiles(allowMultiple: false);
      if (selectedFiles.isEmpty) {
        _mediaPickerStatus = EditMediaPickerStatus.success;
        notifyListeners();
        return;
      }

      final selectedFile = selectedFiles.first;
      _selectedMediaName = selectedFile.name;
      _selectedMediaPath = selectedFile.path;
      _mediaPickerStatus = EditMediaPickerStatus.success;
      notifyListeners();
    } catch (error, stackTrace) {
      _logger.e(
        'Error picking media from file picker for edit.',
        error: error,
        stackTrace: stackTrace,
      );
      _mediaPickerStatus = EditMediaPickerStatus.failure;
      _mediaPickerErrorMessage =
          'An error occurred while picking the file. Please try again.';
      notifyListeners();
    }
  }

  void clearSelectedMedia() {
    _selectedMediaName = null;
    _selectedMediaPath = null;
    _mediaPickerErrorMessage = null;
    _mediaPickerStatus = EditMediaPickerStatus.initial;
    notifyListeners();
  }

  Future<void> saveRecipe(
    String name,
    String description,
    String type, {
    List<String> steps = const [],
    List<String> ingredients = const [],
  }) async {
    final recipe = _recipeDetail;
    if (recipe == null) {
      _updateRecipeStatus = UpdateRecipeStatus.failure;
      notifyListeners();
      return;
    }

    try {
      final normalizedName = _normalizeRequiredText(name, fieldName: 'name');
      final normalizedDescription = _normalizeRequiredText(
        description,
        fieldName: 'description',
      );
      final normalizedImageUrl = _normalizeRequiredText(
        _selectedMediaPath ?? '',
        fieldName: 'imageUrl',
      );
      final normalizedType = _normalizeRequiredText(type, fieldName: 'type');
      final normalizedSteps = _normalizeRequiredList(steps, fieldName: 'steps');
      final normalizedIngredients = _normalizeRequiredList(
        ingredients,
        fieldName: 'ingredients',
      );

      final request = EditRecipeRequestDto(
        uuid: recipe.uuid,
        name: normalizedName,
        description: normalizedDescription,
        imageUrl: normalizedImageUrl,
        type: normalizedType,
        steps: normalizedSteps,
        ingredients: normalizedIngredients,
        createdAt: recipe.createdAt,
      );

      _updatedRecipe = null;
      _updateRecipeStatus = UpdateRecipeStatus.loading;
      notifyListeners();

      _updatedRecipe = await updateRecipe(request);
      _updateRecipeStatus = UpdateRecipeStatus.success;
      notifyListeners();
      _logger.d('Recipe updated successfully. ID: ${recipe.uuid}');
    } catch (e) {
      _updatedRecipe = null;
      _updateRecipeStatus = UpdateRecipeStatus.failure;
      notifyListeners();
      _logger.e('Error updating recipe. ID: ${recipe.uuid} - $e');
    }
  }

  String _normalizeRequiredText(String value, {required String fieldName}) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(
        value,
        fieldName,
        '$fieldName cannot be empty.',
      );
    }

    return normalized;
  }

  List<String> _normalizeRequiredList(
    List<String> values, {
    required String fieldName,
  }) {
    final normalized = values
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty);

    final items = normalized.toList(growable: false);
    if (items.isEmpty) {
      throw ArgumentError.value(
        values,
        fieldName,
        '$fieldName must contain at least one non-empty item.',
      );
    }

    return items;
  }

  String _extractMediaName(String path) {
    final normalizedPath = path.trim();
    if (normalizedPath.isEmpty) {
      return '';
    }

    final segments = normalizedPath.split(RegExp(r'[\\/]'));
    final lastSegment = segments.isNotEmpty ? segments.last.trim() : '';

    return lastSegment.isNotEmpty ? lastSegment : normalizedPath;
  }
}
