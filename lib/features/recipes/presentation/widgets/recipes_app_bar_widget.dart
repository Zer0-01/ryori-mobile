import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/recipes/presentation/viewmodels/recipes_view_model.dart';

class RecipesAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const RecipesAppBarWidget({super.key});

  static const String _allTypesValue = '__all_types__';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesViewModel>(
      builder: (context, vm, child) {
        final colorScheme = Theme.of(context).colorScheme;

        return AppBar(
          title: const Text("Ryori"),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onSurface,
                  backgroundColor:
                      vm.hasActiveTypeFilter
                          ? colorScheme.secondaryContainer
                          : colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                onPressed: () => _showTypePicker(context, vm),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      vm.selectedType ?? 'All',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                            vm.hasActiveTypeFilter
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color:
                          vm.hasActiveTypeFilter
                              ? colorScheme.onSecondaryContainer
                              : colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTypePicker(
    BuildContext context,
    RecipesViewModel vm,
  ) async {
    final String? result = await showModalBottomSheet<String?>(
      showDragHandle: true,
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.all_inclusive_rounded),
              title: const Text('All'),
              selected: vm.selectedType == null,
              onTap: () {
                Navigator.pop(context, _allTypesValue);
              },
            ),
            ...vm.types.map(
              (type) => ListTile(
                title: Text(type.name),
                selected: vm.selectedType == type.name,
                onTap: () {
                  Navigator.pop(context, type.name);
                },
              ),
            ),
          ],
        );
      },
    );

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      return;
    }

    if (result == _allTypesValue) {
      await vm.clearTypeFilter();
      return;
    }

    await vm.fetchRecipes(type: result);
  }
}
