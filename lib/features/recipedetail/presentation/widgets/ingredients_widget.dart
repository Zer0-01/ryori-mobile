import 'package:flutter/material.dart';

class IngredientsWidget extends StatelessWidget {
  final List<String> ingredients;

  const IngredientsWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return _ListSectionWidget(
      title: 'Ingredients',
      icon: Icons.shopping_basket_outlined,
      items: ingredients,
    );
  }
}

class _ListSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;

  const _ListSectionWidget({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (var index = 0; index < items.length; index++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      items[index],
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.4),
                    ),
                  ),
                ],
              ),
              if (index < items.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
