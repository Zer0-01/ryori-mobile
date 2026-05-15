import 'package:flutter/material.dart';

class TypeWidget extends StatelessWidget {
  final String type;

  const TypeWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              Icons.category_outlined,
              color: colorScheme.onPrimaryContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                type,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
