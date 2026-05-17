import 'package:flutter/material.dart';

class RecipeStepsFormWidget extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onAddPressed;
  final ValueChanged<int> onRemovePressed;
  final String? errorText;

  const RecipeStepsFormWidget({
    super.key,
    required this.controllers,
    required this.onAddPressed,
    required this.onRemovePressed,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedErrorText = errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Steps',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var index = 0; index < controllers.length; index++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controllers[index],
                  minLines: 2,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Step ${index + 1}',
                    hintText: 'Describe this step',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed:
                    controllers.length > 1
                        ? () => onRemovePressed(index)
                        : null,
                tooltip: 'Remove step',
                icon: const Icon(Icons.remove_circle_outline_rounded),
              ),
            ],
          ),
          if (index < controllers.length - 1) const SizedBox(height: 12),
        ],
        if (resolvedErrorText != null) ...[
          const SizedBox(height: 8),
          Text(
            resolvedErrorText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.error),
          ),
        ],
      ],
    );
  }
}
