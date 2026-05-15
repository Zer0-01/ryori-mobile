import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/recipedetail/presentation/viewmodels/recipe_detail_view_model.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/delete_recipe_button_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/description_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/ingredients_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/recipe_image_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/steps_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/title_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/type_widget.dart';

class RecipeDetailContentWidget extends StatelessWidget {
  const RecipeDetailContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeDetailViewModel>(
      builder: (context, vm, child) {
        if (vm.getRecipeDetailStatus == GetRecipeDetailStatus.initial ||
            vm.getRecipeDetailStatus == GetRecipeDetailStatus.loading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.getRecipeDetailStatus == GetRecipeDetailStatus.failure) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('Failed to load recipe detail')),
          );
        }

        if (vm.getRecipeDetailStatus == GetRecipeDetailStatus.success) {
          if (vm.recipeDetail == null) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Recipe not found')),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RecipeImageWidget(imageUrl: vm.recipeDetail!.imageUrl),
                  const SizedBox(height: 20),
                  TitleWidget(title: vm.recipeDetail!.title),
                  const SizedBox(height: 16),
                  TypeWidget(type: vm.recipeDetail!.type),
                  const SizedBox(height: 16),
                  DescriptionWidget(description: vm.recipeDetail!.description),
                  const SizedBox(height: 16),
                  IngredientsWidget(ingredients: vm.recipeDetail!.ingredients),
                  const SizedBox(height: 16),
                  StepsWidget(steps: vm.recipeDetail!.steps),
                  const SizedBox(height: 24),
                  const DeleteRecipeButtonWidget(),
                ],
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
