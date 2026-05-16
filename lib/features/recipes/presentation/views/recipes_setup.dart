import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/recipes/presentation/viewmodels/recipes_view_model.dart';
import 'package:ryori/features/recipes/presentation/views/recipes_view.dart';

@RoutePage()
class RecipesSetup extends StatelessWidget {
  const RecipesSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<RecipesViewModel>(),
      child: const RecipesView(),
    );
  }
}
