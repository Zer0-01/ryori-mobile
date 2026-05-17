import 'package:flutter/material.dart';

class TypeWidget extends StatelessWidget {
  final String type;
  final String? badgeColor;

  const TypeWidget({
    super.key,
    required this.type,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final backgroundColor =
        _parseBadgeColor(badgeColor) ??
        Theme.of(context).colorScheme.primaryContainer;
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(backgroundColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black87;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              Icons.category_outlined,
              color: foregroundColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                type,
                style: textTheme.titleSmall?.copyWith(
                  color: foregroundColor,
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

Color? _parseBadgeColor(String? value) {
  final normalized = value?.trim();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  final hex = normalized.startsWith('#') ? normalized.substring(1) : normalized;
  if (hex.length != 6 && hex.length != 8) {
    return null;
  }

  final parsed = int.tryParse(
    hex.length == 6 ? 'FF$hex' : hex,
    radix: 16,
  );

  if (parsed == null) {
    return null;
  }

  return Color(parsed);
}
