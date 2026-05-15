import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/recipedetail/presentation/viewmodels/recipe_detail_view_model.dart';
import 'package:ryori/features/recipedetail/presentation/views/recipe_detail_view.dart';

@RoutePage()
class RecipeDetailSetup extends StatelessWidget {
  final String recipeId;

  const RecipeDetailSetup({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<RecipeDetailViewModel>(param1: recipeId),
      child: const RecipeDetailView(),
    );
  }
}
