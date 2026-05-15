import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/core/utils/dialog_utils.dart';
import 'package:ryori/core/utils/toast_utils.dart';
import 'package:ryori/features/editrecipe/presentation/viewmodels/edit_recipe_view_model.dart';
import 'package:ryori/features/editrecipe/presentation/widgets/edit_recipe_app_bar_widget.dart';
import 'package:ryori/features/editrecipe/presentation/widgets/edit_recipe_form_widget.dart';

class EditRecipeView extends StatefulWidget {
  const EditRecipeView({super.key});

  @override
  State<EditRecipeView> createState() => _EditRecipeViewState();
}

class _EditRecipeViewState extends State<EditRecipeView> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _typeController;
  late final List<TextEditingController> _ingredientControllers;
  late final List<TextEditingController> _stepControllers;
  late final EditRecipeViewModel _vm;
  UpdateRecipeStatus? _previousUpdateRecipeStatus;
  EditMediaPickerStatus? _previousMediaPickerStatus;
  bool _hasPrefilledControllers = false;

  @override
  void initState() {
    super.initState();
    _vm = context.read<EditRecipeViewModel>();
    _previousUpdateRecipeStatus = _vm.updateRecipeStatus;
    _previousMediaPickerStatus = _vm.mediaPickerStatus;
    _vm.addListener(_listener);

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _typeController = TextEditingController();
    _ingredientControllers = [TextEditingController()];
    _stepControllers = [TextEditingController()];
  }

  @override
  void dispose() {
    _vm.removeListener(_listener);
    _disposeControllers(_ingredientControllers);
    _disposeControllers(_stepControllers);
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _listener() {
    final currentUpdateRecipeStatus = _vm.updateRecipeStatus;
    final updateStatusChanged =
        _previousUpdateRecipeStatus != currentUpdateRecipeStatus;
    final currentMediaPickerStatus = _vm.mediaPickerStatus;
    final mediaStatusChanged =
        _previousMediaPickerStatus != currentMediaPickerStatus;

    if (updateStatusChanged) {
      _previousUpdateRecipeStatus = currentUpdateRecipeStatus;

      if (currentUpdateRecipeStatus == UpdateRecipeStatus.loading) {
        showLoadingDialog(context);
      } else if (currentUpdateRecipeStatus == UpdateRecipeStatus.success) {
        Navigator.pop(context);
        showSuccessToast(
          context,
          'Saved Successfully',
          'The recipe detail has been updated.',
        );
        context.router.maybePop(true);
      } else if (currentUpdateRecipeStatus == UpdateRecipeStatus.failure) {
        Navigator.pop(context);
        showErrorToast(
          context,
          'Failed to Save',
          'An error occurred while saving the recipe. Please try again.',
        );
      }
    }

    if (mediaStatusChanged) {
      _previousMediaPickerStatus = currentMediaPickerStatus;

      if (currentMediaPickerStatus == EditMediaPickerStatus.loading) {
        showLoadingDialog(context);
        return;
      }
      if (currentMediaPickerStatus == EditMediaPickerStatus.success) {
        Navigator.pop(context);
        return;
      }

      if (currentMediaPickerStatus == EditMediaPickerStatus.failure) {
        Navigator.pop(context);
        showErrorToast(
          context,
          'Failed to Pick File',
          _vm.mediaPickerErrorMessage ??
              'An error occurred while picking the file. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditRecipeAppBarWidget(),
      body: Consumer<EditRecipeViewModel>(
        builder: (context, vm, child) {
          final isLoading =
              vm.recipeDetailStatus == EditRecipeLoadStatus.initial ||
              vm.recipeDetailStatus == EditRecipeLoadStatus.loading ||
              vm.getTypesStatus == EditRecipeLoadStatus.initial ||
              vm.getTypesStatus == EditRecipeLoadStatus.loading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final hasFailure =
              vm.recipeDetailStatus == EditRecipeLoadStatus.failure ||
              vm.getTypesStatus == EditRecipeLoadStatus.failure;
          if (hasFailure) {
            return const Center(
              child: Text('Failed to load recipe data for editing'),
            );
          }

          if (vm.isInitialDataReady && !_hasPrefilledControllers) {
            _prefillControllers(vm);
          }

          if (!vm.isInitialDataReady) {
            return const SizedBox.shrink();
          }

          return CustomScrollView(
            slivers: [
              EditRecipeFormWidget(
                nameController: _nameController,
                descriptionController: _descriptionController,
                typeController: _typeController,
                ingredientControllers: _ingredientControllers,
                stepControllers: _stepControllers,
                onAddIngredientPressed: _addIngredientField,
                onAddStepPressed: _addStepField,
                onRemoveIngredientPressed: _removeIngredientField,
                onRemoveStepPressed: _removeStepField,
              ),
            ],
          );
        },
      ),
    );
  }

  void _prefillControllers(EditRecipeViewModel vm) {
    final recipe = vm.recipeDetail;
    if (recipe == null) {
      return;
    }

    _nameController.text = recipe.title;
    _descriptionController.text = recipe.description;
    _typeController.text = recipe.type;

    _disposeControllers(_ingredientControllers);
    _disposeControllers(_stepControllers);

    _ingredientControllers
      ..clear()
      ..addAll(
        recipe.ingredients.map((item) => TextEditingController(text: item)),
      );
    _stepControllers
      ..clear()
      ..addAll(recipe.steps.map((item) => TextEditingController(text: item)));

    if (_ingredientControllers.isEmpty) {
      _ingredientControllers.add(TextEditingController());
    }
    if (_stepControllers.isEmpty) {
      _stepControllers.add(TextEditingController());
    }

    _hasPrefilledControllers = true;
  }

  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredientField(int index) {
    if (_ingredientControllers.length <= 1) {
      return;
    }

    setState(() {
      final controller = _ingredientControllers.removeAt(index);
      controller.dispose();
    });
  }

  void _addStepField() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }

  void _removeStepField(int index) {
    if (_stepControllers.length <= 1) {
      return;
    }

    setState(() {
      final controller = _stepControllers.removeAt(index);
      controller.dispose();
    });
  }

  void _disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
}
