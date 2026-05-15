import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/addrecipe/presentation/viewmodels/add_recipe_view_model.dart';
import 'package:ryori/features/addrecipe/presentation/views/add_recipe_view.dart';

@RoutePage()
class AddRecipeSetup extends StatelessWidget {
  const AddRecipeSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<AddRecipeViewModel>(),
      child: const AddRecipeView(),
    );
  }
}
