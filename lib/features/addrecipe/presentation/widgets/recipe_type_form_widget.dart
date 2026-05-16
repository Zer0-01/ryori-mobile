import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/addrecipe/presentation/viewmodels/add_recipe_view_model.dart';

class RecipeTypeFormWidget extends StatelessWidget {
  final TextEditingController controller;

  const RecipeTypeFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddRecipeViewModel>(
      builder: (context, vm, child) {
        final normalizedValue = controller.text.trim();
        final selectedValue =
            vm.types.any((type) => type.name == normalizedValue)
                ? normalizedValue
                : null;

        return DropdownButtonFormField<String>(
          initialValue: selectedValue,
          isExpanded: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Type cannot be empty';
            }

            return null;
          },
          items:
              vm.types
                  .map(
                    (type) => DropdownMenuItem<String>(
                      value: type.name,
                      child: Text(type.name),
                    ),
                  )
                  .toList(growable: false),
          onChanged: (value) {
            controller.text = value?.trim() ?? '';
          },
          decoration: const InputDecoration(
            labelText: 'Type',
            hintText: 'Select recipe type',
          ),
        );
      },
    );
  }
}
