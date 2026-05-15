import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/logger/app_logger.dart';
import 'package:ryori/core/utils/picker_service.dart';
import 'package:ryori/features/addrecipe/data/models/requests/add_recipe_request_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/add_recipe_response_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/addrecipe/domain/usecases/get_type.dart';
import 'package:ryori/features/addrecipe/domain/usecases/post_recipe.dart';

enum GetTypesStatus { initial, loading, success, failure }

enum PostRecipeStatus { initial, loading, success, failure }

enum MediaPickerStatus { initial, loading, success, failure }

@injectable
class AddRecipeViewModel extends ChangeNotifier {
  AddRecipeViewModel(this.getType, this.postRecipe, this.pickerService) {
    init();
  }

  final GetType getType;
  final PostRecipe postRecipe;
  final PickerService pickerService;

  final AppLogger _logger = AppLogger(tag: 'AddRecipeViewModel');

  GetTypesStatus _getTypesStatus = GetTypesStatus.initial;
  GetTypesStatus get getTypesStatus => _getTypesStatus;

  PostRecipeStatus _postRecipeStatus = PostRecipeStatus.initial;
  PostRecipeStatus get postRecipeStatus => _postRecipeStatus;

  MediaPickerStatus _mediaPickerStatus = MediaPickerStatus.initial;
  MediaPickerStatus get mediaPickerStatus => _mediaPickerStatus;

  AddRecipeResponseDto? _createdRecipe;
  AddRecipeResponseDto? get createdRecipe => _createdRecipe;

  final List<TypeData> _types = [];
  List<TypeData> get types => _types;

  String? _selectedMediaName;
  String? get selectedMediaName => _selectedMediaName;

  String? _selectedMediaPath;
  String? get selectedMediaPath => _selectedMediaPath;
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

  String? _mediaPickerErrorMessage;
  String? get mediaPickerErrorMessage => _mediaPickerErrorMessage;

  Future<void> init() async {
    await fetchTypes();
  }

  Future<void> fetchTypes() async {
    _getTypesStatus = GetTypesStatus.loading;
    notifyListeners();

    _logger.d("Entering fetchTypes method");
    try {
      final types = await getType();
      _getTypesStatus = GetTypesStatus.success;
      _types.clear();
      _types.addAll(types.data);
      notifyListeners();
      _logger.d("Fetched ${types.data.length} types");
    } catch (e) {
      _getTypesStatus = GetTypesStatus.failure;
      _types.clear();
      notifyListeners();
      _logger.e("Error fetching types: $e");
    }
  }

  Future<void> pickFromGallery() async {
    _mediaPickerStatus = MediaPickerStatus.loading;
    _mediaPickerErrorMessage = null;
    notifyListeners();

    try {
      final selectedImage = await pickerService.pickImageFromGallery();
      if (selectedImage == null) {
        _mediaPickerStatus = MediaPickerStatus.success;
        notifyListeners();
        return;
      }

      _selectedMediaName = selectedImage.name;
      _selectedMediaPath = selectedImage.path;
      _mediaPickerStatus = MediaPickerStatus.success;
      notifyListeners();
    } catch (error, stackTrace) {
      _logger.e(
        'Error picking media from gallery.',
        error: error,
        stackTrace: stackTrace,
      );
      _mediaPickerStatus = MediaPickerStatus.failure;
      _mediaPickerErrorMessage =
          'An error occurred while picking the image. Please try again.';
      notifyListeners();
    }
  }

  Future<void> pickFromFile() async {
    _mediaPickerStatus = MediaPickerStatus.loading;
    _mediaPickerErrorMessage = null;
    notifyListeners();

    try {
      final selectedFiles = await pickerService.pickFiles(allowMultiple: false);
      if (selectedFiles.isEmpty) {
        _mediaPickerStatus = MediaPickerStatus.success;
        notifyListeners();
        return;
      }

      final selectedFile = selectedFiles.first;
      _selectedMediaName = selectedFile.name;
      _selectedMediaPath = selectedFile.path;
      _mediaPickerStatus = MediaPickerStatus.success;
      notifyListeners();
    } catch (error, stackTrace) {
      _logger.e(
        'Error picking media from file picker.',
        error: error,
        stackTrace: stackTrace,
      );
      _mediaPickerStatus = MediaPickerStatus.failure;
      _mediaPickerErrorMessage =
          'An error occurred while picking the file. Please try again.';
      notifyListeners();
    }
  }

  void clearSelectedMedia() {
    _selectedMediaName = null;
    _selectedMediaPath = null;
    _mediaPickerErrorMessage = null;
    _mediaPickerStatus = MediaPickerStatus.initial;
    notifyListeners();
  }

  Future<void> saveRecipe(
    String name,
    String description,
    String type, {
    List<String> steps = const [],
    List<String> ingredients = const [],
  }) async {
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

      final request = AddRecipeRequestDto(
        name: normalizedName,
        description: normalizedDescription,
        imageUrl: normalizedImageUrl,
        type: normalizedType,
        steps: normalizedSteps,
        ingredients: normalizedIngredients,
        createdAt: DateTime.now(),
      );

      _logger.d("Saving recipe...");
      _createdRecipe = null;
      _postRecipeStatus = PostRecipeStatus.loading;
      notifyListeners();

      _createdRecipe = await postRecipe(request);
      _postRecipeStatus = PostRecipeStatus.success;
      notifyListeners();
      _logger.d("Recipe saved successfully");
    } catch (e) {
      _createdRecipe = null;
      _postRecipeStatus = PostRecipeStatus.failure;
      notifyListeners();
      _logger.e("Error saving recipe: $e");
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
}
