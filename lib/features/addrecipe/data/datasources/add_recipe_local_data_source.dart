import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/database/app_database.dart';
import 'package:ryori/features/addrecipe/data/models/requests/add_recipe_request_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/add_recipe_response_dto.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';

@lazySingleton
class AddRecipeLocalDataSource {
  AddRecipeLocalDataSource(this._database);

  static const String _recipeTypesAssetPath = 'asset/json/recipetypes.json';
  final AppDatabase _database;

  Future<TypeResponseDto> getTypes() async {
    final rawJson = await rootBundle.loadString(_recipeTypesAssetPath);
    final decodedJson = jsonDecode(rawJson) as Map<String, dynamic>;
    final rawData = decodedJson['data'] as List<dynamic>;

    return TypeResponseDto(
      data:
          rawData
              .map(
                (item) => TypeData(
                  id: item['id'] as int,
                  name: item['name'] as String,
                  badgeColor: item['badgeColor'] as String,
                ),
              )
              .toList(),
    );
  }

  Future<AddRecipeResponseDto> postRecipe(AddRecipeRequestDto request) async {
    final uuid = _buildRecipeUuid(request);

    await _database.into(_database.recipes).insertOnConflictUpdate(
      RecipesCompanion.insert(
        uuid: uuid,
        title: request.name,
        description: request.description,
        imageUrl: request.imageUrl,
        type: request.type,
        steps: request.steps,
        ingredients: request.ingredients,
        createdAt: request.createdAt,
      ),
    );

    final createdRecipe =
        await (_database.select(
          _database.recipes,
        )..where((recipe) => recipe.uuid.equals(uuid))).getSingle();

    return AddRecipeResponseDto.fromRecipeRow(createdRecipe);
  }

  String _buildRecipeUuid(AddRecipeRequestDto request) {
    final normalizedName =
        request.name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '-');

    return '${request.createdAt.microsecondsSinceEpoch}-$normalizedName';
  }
}
