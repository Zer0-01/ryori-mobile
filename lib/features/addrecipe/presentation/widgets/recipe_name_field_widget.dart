import 'package:flutter/material.dart';

class RecipeNameFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const RecipeNameFieldWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name cannot be empty';
        }

        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Name',
        hintText: 'Enter recipe name',
      ),
    );
  }
}
