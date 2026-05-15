import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/addrecipe/presentation/widgets/recipe_description_field_widget.dart';
import 'package:ryori/features/addrecipe/presentation/widgets/recipe_ingredients_form_widget.dart';
import 'package:ryori/features/addrecipe/presentation/widgets/recipe_name_field_widget.dart';
import 'package:ryori/features/addrecipe/presentation/widgets/recipe_steps_form_widget.dart';
import 'package:ryori/features/editrecipe/presentation/viewmodels/edit_recipe_view_model.dart';
import 'package:ryori/features/editrecipe/presentation/widgets/edit_media_picker_widget.dart';
import 'package:ryori/features/editrecipe/presentation/widgets/edit_recipe_button_widget.dart';
import 'package:ryori/features/editrecipe/presentation/widgets/edit_recipe_type_form_widget.dart';

class EditRecipeFormWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController typeController;
  final List<TextEditingController> ingredientControllers;
  final List<TextEditingController> stepControllers;
  final VoidCallback onAddIngredientPressed;
  final VoidCallback onAddStepPressed;
  final ValueChanged<int> onRemoveIngredientPressed;
  final ValueChanged<int> onRemoveStepPressed;

  const EditRecipeFormWidget({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.typeController,
    required this.ingredientControllers,
    required this.stepControllers,
    required this.onAddIngredientPressed,
    required this.onAddStepPressed,
    required this.onRemoveIngredientPressed,
    required this.onRemoveStepPressed,
  });

  @override
  State<EditRecipeFormWidget> createState() => _EditRecipeFormWidgetState();
}

class _EditRecipeFormWidgetState extends State<EditRecipeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showMediaError = false;
  bool _showIngredientsError = false;
  bool _showStepsError = false;

  @override
  Widget build(BuildContext context) {
    final hasSelectedMedia = context.watch<EditRecipeViewModel>().hasSelectedMedia;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EditMediaPickerWidget(
                errorText:
                    _showMediaError && !hasSelectedMedia
                        ? 'Recipe media cannot be empty'
                        : null,
              ),
              const SizedBox(height: 16),
              RecipeNameFieldWidget(controller: widget.nameController),
              const SizedBox(height: 16),
              RecipeDescriptionFieldWidget(
                controller: widget.descriptionController,
              ),
              const SizedBox(height: 16),
              EditRecipeTypeFormWidget(controller: widget.typeController),
              const SizedBox(height: 24),
              RecipeIngredientsFormWidget(
                controllers: widget.ingredientControllers,
                onAddPressed: widget.onAddIngredientPressed,
                onRemovePressed: _handleRemoveIngredient,
                errorText:
                    _showIngredientsError
                        ? 'Ingredient list cannot be empty'
                        : null,
              ),
              const SizedBox(height: 24),
              RecipeStepsFormWidget(
                controllers: widget.stepControllers,
                onAddPressed: widget.onAddStepPressed,
                onRemovePressed: _handleRemoveStep,
                errorText: _showStepsError ? 'Step list cannot be empty' : null,
              ),
              const SizedBox(height: 24),
              Consumer<EditRecipeViewModel>(
                builder: (context, vm, child) {
                  return EditRecipeButtonWidget(
                    isLoading:
                        vm.updateRecipeStatus == UpdateRecipeStatus.loading,
                    onPressed: () => _submit(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final hasMedia = context.read<EditRecipeViewModel>().hasSelectedMedia;
    final ingredients = _normalizeControllers(widget.ingredientControllers);
    final steps = _normalizeControllers(widget.stepControllers);
    final hasIngredients = ingredients.isNotEmpty;
    final hasSteps = steps.isNotEmpty;

    setState(() {
      _showMediaError = !hasMedia;
      _showIngredientsError = !hasIngredients;
      _showStepsError = !hasSteps;
    });

    if (!isFormValid || !hasMedia || !hasIngredients || !hasSteps) {
      return;
    }

    context.read<EditRecipeViewModel>().saveRecipe(
      widget.nameController.text,
      widget.descriptionController.text,
      widget.typeController.text,
      ingredients: ingredients,
      steps: steps,
    );
  }

  void _handleRemoveIngredient(int index) {
    widget.onRemoveIngredientPressed(index);
    if (_showIngredientsError) {
      setState(() {
        _showIngredientsError =
            _normalizeControllers(widget.ingredientControllers).isEmpty;
      });
    }
  }

  void _handleRemoveStep(int index) {
    widget.onRemoveStepPressed(index);
    if (_showStepsError) {
      setState(() {
        _showStepsError = _normalizeControllers(widget.stepControllers).isEmpty;
      });
    }
  }

  List<String> _normalizeControllers(List<TextEditingController> controllers) {
    return controllers
        .map((controller) => controller.text.trim())
        .where((value) => value.isNotEmpty)
        .toList(growable: false);
  }
}
