import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/core/utils/dialog_utils.dart';
import 'package:ryori/core/utils/toast_utils.dart';
import 'package:ryori/features/addrecipe/presentation/viewmodels/add_recipe_view_model.dart';
import 'package:ryori/features/addrecipe/presentation/widgets/add_recipe_app_bar_widget.dart';
import 'package:ryori/features/addrecipe/presentation/widgets/recipe_form_widget.dart';

class AddRecipeView extends StatefulWidget {
  const AddRecipeView({super.key});

  @override
  State<AddRecipeView> createState() => _AddRecipeViewState();
}

class _AddRecipeViewState extends State<AddRecipeView> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _typeController;
  late final List<TextEditingController> _ingredientControllers;
  late final List<TextEditingController> _stepControllers;
  late final AddRecipeViewModel _vm;
  PostRecipeStatus? _previousPostRecipeStatus;
  MediaPickerStatus? _previousMediaPickerStatus;

  @override
  void initState() {
    super.initState();
    _vm = context.read<AddRecipeViewModel>();
    _previousPostRecipeStatus = _vm.postRecipeStatus;
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
    for (final controller in _ingredientControllers) {
      controller.dispose();
    }
    for (final controller in _stepControllers) {
      controller.dispose();
    }
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _listener() {
    final currentPostRecipeStatus = _vm.postRecipeStatus;
    final statusChanged = _previousPostRecipeStatus != currentPostRecipeStatus;
    final currentMediaPickerStatus = _vm.mediaPickerStatus;
    final mediaStatusChanged =
        _previousMediaPickerStatus != currentMediaPickerStatus;

    if (statusChanged) {
      _previousPostRecipeStatus = currentPostRecipeStatus;

      if (currentPostRecipeStatus == PostRecipeStatus.loading) {
        showLoadingDialog(context);
      } else if (currentPostRecipeStatus == PostRecipeStatus.success) {
        Navigator.pop(context);
        showSuccessToast(
          context,
          "Saved Successfully",
          "Check the data in the home page",
        );
        context.router.maybePop(true);
      } else if (currentPostRecipeStatus == PostRecipeStatus.failure) {
        Navigator.pop(context);
        showErrorToast(
          context,
          "Failed to Save",
          "An error occurred while saving the recipe. Please try again.",
        );
      }
    }
    if (mediaStatusChanged) {
      _previousMediaPickerStatus = currentMediaPickerStatus;

      if (currentMediaPickerStatus == MediaPickerStatus.loading) {
        showLoadingDialog(context);
        return;
      }
      if (currentMediaPickerStatus == MediaPickerStatus.success) {
        Navigator.pop(context);
        return;
      }

      if (currentMediaPickerStatus == MediaPickerStatus.failure) {
        Navigator.pop(context);
        showErrorToast(
          context,
          "Failed to Pick File",
          _vm.mediaPickerErrorMessage ??
              "An error occurred while picking the file. Please try again.",
        );
        return;
      }
    }

    if (mediaStatusChanged &&
        currentMediaPickerStatus == MediaPickerStatus.failure &&
        _vm.mediaPickerErrorMessage != null) {
      showErrorToast(
        context,
        "Failed to Pick File",
        _vm.mediaPickerErrorMessage!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddRecipeAppBarWidget(),
      body: Consumer<AddRecipeViewModel>(
        builder: (context, vm, child) {
          if (vm.getTypesStatus == GetTypesStatus.loading ||
              vm.getTypesStatus == GetTypesStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (vm.getTypesStatus == GetTypesStatus.failure) {
            return const Center(child: Text("Failed to load recipe types"));
          } else if (vm.getTypesStatus == GetTypesStatus.success) {
            return CustomScrollView(
              slivers: [
                RecipeFormWidget(
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
          }
          return const SizedBox.shrink();
        },
      ),
    );
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
}
