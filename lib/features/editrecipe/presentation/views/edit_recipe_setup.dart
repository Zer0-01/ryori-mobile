import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/editrecipe/presentation/viewmodels/edit_recipe_view_model.dart';
import 'package:ryori/features/editrecipe/presentation/views/edit_recipe_view.dart';

@RoutePage()
class EditRecipeSetup extends StatelessWidget {
  final String recipeId;

  const EditRecipeSetup({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<EditRecipeViewModel>(param1: recipeId),
      child: const EditRecipeView(),
    );
  }
}
