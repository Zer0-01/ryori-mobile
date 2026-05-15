import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/home/presentation/viewmodels/home_view_model.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  static const String _allTypesValue = '__all_types__';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return AppBar(
          title: const Text("Ryori"),
          actions: [
            IconButton(
              onPressed: () => _showTypePicker(context, vm),
              tooltip:
                  vm.selectedType == null
                      ? 'Filter by type'
                      : 'Filter: ${vm.selectedType}',
              icon: Badge.count(
                isLabelVisible: vm.hasActiveTypeFilter,
                count: 1,
                child: const Icon(Icons.filter_list_rounded),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTypePicker(
    BuildContext context,
    HomeViewModel vm,
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
