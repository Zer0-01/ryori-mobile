import 'package:flutter/material.dart';

class EditRecipeButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const EditRecipeButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child:
          isLoading
              ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : const Text('Save Changes'),
    );
  }
}
