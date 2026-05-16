import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/router/app_router.gr.dart';
import 'package:ryori/features/recipes/presentation/viewmodels/recipes_view_model.dart';

class RecipesListWidget extends StatelessWidget {
  const RecipesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesViewModel>(
      builder: (context, vm, child) {
        if (vm.status == GetRecipesStatus.loading ||
            vm.status == GetRecipesStatus.initial) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (vm.status == GetRecipesStatus.failure) {
          final colorScheme = Theme.of(context).colorScheme;
          final textTheme = Theme.of(context).textTheme;

          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.cloud_off_rounded,
                              color: colorScheme.onErrorContainer,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Failed to load recipes",
                            textAlign: TextAlign.center,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Something went wrong while loading your recipes. Try again to refresh the list.",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          FilledButton.icon(
                            onPressed:
                                () => vm.fetchRecipes(type: vm.selectedType),
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (vm.status == GetRecipesStatus.success) {
          if (vm.recipes.isEmpty) {
            final colorScheme = Theme.of(context).colorScheme;
            final textTheme = Theme.of(context).textTheme;

            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 28,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.menu_book_outlined,
                                color: colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "No recipes found",
                              textAlign: TextAlign.center,
                              style: textTheme.titleMedium?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              vm.hasActiveTypeFilter
                                  ? "No recipes match the selected type. Choose another type or clear the filter."
                                  : "Your recipe list is empty for now. Add or sync recipes to see them here.",
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final recipe = vm.recipes[index];
                final colorScheme = Theme.of(context).colorScheme;
                final textTheme = Theme.of(context).textTheme;

                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  color: colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  child: InkWell(
                    onTap: () async {
                      final bool? isRefreshed = await context.router.push(
                        RecipeDetailSetup(recipeId: recipe.uuid),
                      );

                      if (isRefreshed == true && context.mounted) {
                        await vm.fetchRecipes(type: vm.selectedType);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _RecipeCardImage(imageUrl: recipe.imageUrl),
                          const SizedBox(height: 16),
                          Text(
                            recipe.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recipe.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              _RecipeTypeBadge(type: recipe.type),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  _formatCreatedAt(recipe.createdAt),
                                  style: textTheme.labelMedium?.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: vm.recipes.length,
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

String _formatCreatedAt(DateTime createdAt) {
  final monthNames = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${monthNames[createdAt.month - 1]} ${createdAt.day}, ${createdAt.year}';
}

class _RecipeCardImage extends StatelessWidget {
  const _RecipeCardImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.file(
          File(imageUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const _RecipeCardImageFallback();
          },
        ),
      ),
    );
  }
}

class _RecipeCardImageFallback extends StatelessWidget {
  const _RecipeCardImageFallback();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 36,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}

class _RecipeTypeBadge extends StatelessWidget {
  const _RecipeTypeBadge({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = _resolveTypeBadgeColors(Theme.of(context).colorScheme, type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        type,
        style: textTheme.labelMedium?.copyWith(
          color: colors.foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

_TypeBadgeColors _resolveTypeBadgeColors(ColorScheme colorScheme, String type) {
  final normalizedType = type.trim().toLowerCase();
  final palettes = <_TypeBadgeColors>[
    _TypeBadgeColors(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
    ),
    _TypeBadgeColors(
      backgroundColor: colorScheme.secondaryContainer,
      foregroundColor: colorScheme.onSecondaryContainer,
    ),
    _TypeBadgeColors(
      backgroundColor: colorScheme.tertiaryContainer,
      foregroundColor: colorScheme.onTertiaryContainer,
    ),
    _TypeBadgeColors(
      backgroundColor: colorScheme.errorContainer,
      foregroundColor: colorScheme.onErrorContainer,
    ),
  ];

  final paletteIndex = normalizedType.hashCode.abs() % palettes.length;
  return palettes[paletteIndex];
}

class _TypeBadgeColors {
  const _TypeBadgeColors({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
}
