import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/core/utils/dialog_utils.dart';
import 'package:ryori/core/utils/toast_utils.dart';
import 'package:ryori/features/recipedetail/presentation/viewmodels/recipe_detail_view_model.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/recipe_detail_app_bar_widget.dart';
import 'package:ryori/features/recipedetail/presentation/widgets/recipe_detail_content_widget.dart';

class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({super.key});

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  late final RecipeDetailViewModel _vm;
  DeleteRecipeStatus? _previousDeleteRecipeStatus;

  @override
  void initState() {
    _vm = context.read<RecipeDetailViewModel>();
    _previousDeleteRecipeStatus = _vm.deleteRecipeStatus;
    _vm.addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _vm.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    final currentDeleteRecipeStatus = _vm.deleteRecipeStatus;
    final statusChanged =
        _previousDeleteRecipeStatus != currentDeleteRecipeStatus;

    if (statusChanged) {
      _previousDeleteRecipeStatus = currentDeleteRecipeStatus;
      if (currentDeleteRecipeStatus == DeleteRecipeStatus.loading) {
        showLoadingDialog(context);
        return;
      }

      if (currentDeleteRecipeStatus == DeleteRecipeStatus.failure) {
        Navigator.pop(context);
        showErrorToast(
          context,
          "Failed to Delete",
          "An error occurred while deleting the recipe. Please try again.",
        );
        return;
      }

      if (currentDeleteRecipeStatus == DeleteRecipeStatus.success) {
        Navigator.pop(context);
        showSuccessToast(
          context,
          "Deleted Successfully",
          "Check the data in the home page",
        );
        context.router.maybePop(true);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RecipeDetailAppBarWidget(),
      body: CustomScrollView(slivers: [RecipeDetailContentWidget()]),
    );
  }
}
