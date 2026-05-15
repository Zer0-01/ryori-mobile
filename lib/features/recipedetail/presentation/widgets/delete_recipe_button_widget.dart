import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/recipedetail/presentation/viewmodels/recipe_detail_view_model.dart';

class DeleteRecipeButtonWidget extends StatelessWidget {
  const DeleteRecipeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeDetailViewModel>(
      builder: (context, vm, child) {
        return OutlinedButton.icon(
          onPressed: () => _confirmDelete(context, vm),
          icon: const Icon(Icons.delete_outline_rounded),
          label: const Text('Delete Recipe'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            side: BorderSide(color: Theme.of(context).colorScheme.error),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    RecipeDetailViewModel vm,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete recipe?'),
          content: const Text(
            'This will permanently remove this recipe from your list.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && context.mounted) {
      await vm.deleteRecipe();
    }
  }
}
