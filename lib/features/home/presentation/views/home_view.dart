import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/router/app_router.gr.dart';
import 'package:ryori/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:ryori/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:ryori/features/home/presentation/widgets/recipes_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const HomeAppBarWidget(),
          body: RefreshIndicator(
            onRefresh: () async {
              await vm.fetchRecipes(type: vm.selectedType);
            },
            child: const CustomScrollView(slivers: [RecipesListWidget()]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final isRefresh = await context.router.push(
                const AddRecipeSetup(),
              );

              if (isRefresh == true && context.mounted) {
                await vm.fetchRecipes(type: vm.selectedType);
              }
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
