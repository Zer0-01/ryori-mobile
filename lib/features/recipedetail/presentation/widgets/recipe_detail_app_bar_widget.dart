import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/router/app_router.gr.dart';
import 'package:ryori/features/recipedetail/presentation/viewmodels/recipe_detail_view_model.dart';

class RecipeDetailAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const RecipeDetailAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Consumer<RecipeDetailViewModel>(
          builder: (context, vm, child) {
            final isEnabled =
                vm.getRecipeDetailStatus == GetRecipeDetailStatus.success;

            return IconButton(
              onPressed:
                  isEnabled
                      ? () async {
                        final bool? isUpdated = await context.router.push(
                          EditRecipeSetup(recipeId: vm.resolvedRecipeId),
                        );
                        if (isUpdated == true && context.mounted) {
                          await vm.fetchRecipeDetail(vm.resolvedRecipeId);
                        }
                      }
                      : null,
              icon: const Icon(Icons.edit_rounded),
              tooltip: 'Edit recipe',
            );
          },
        ),
      ],
    );
  }
}
