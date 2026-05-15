import 'package:flutter/material.dart';

class RecipeDescriptionFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const RecipeDescriptionFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 4,
      maxLines: 6,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Description cannot be empty';
        }

        return null;
      },
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        labelText: 'Description',
        hintText: 'Describe the recipe, flavor, or key details',
      ),
    );
  }
}
