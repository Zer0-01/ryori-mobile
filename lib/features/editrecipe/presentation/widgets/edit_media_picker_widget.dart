import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/editrecipe/presentation/viewmodels/edit_recipe_view_model.dart';

class EditMediaPickerWidget extends StatelessWidget {
  final String? errorText;

  const EditMediaPickerWidget({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<EditRecipeViewModel>(
      builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child:
                  vm.hasSelectedMedia
                      ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _MediaPreview(
                                  path: vm.selectedMediaPath!,
                                  isImage: vm.isSelectedMediaImage,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Recipe Media',
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        vm.selectedMediaName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () => _showPickerOptions(context),
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                  ),
                                  label: const Text('Reselect'),
                                ),
                                const SizedBox(width: 8),
                                TextButton.icon(
                                  onPressed: vm.clearSelectedMedia,
                                  icon: const Icon(Icons.delete_outline_rounded),
                                  label: const Text('Remove'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      : ListTile(
                        onTap: () => _showPickerOptions(context),
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.attach_file_rounded),
                        ),
                        title: const Text('Recipe Media'),
                        subtitle: const Text(
                          'Tap to choose an image from gallery or a file',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                      ),
            ),
            if (errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _showPickerOptions(BuildContext context) async {
    final vm = context.read<EditRecipeViewModel>();
    final String? option = await showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop('gallery');
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_file_rounded),
                title: const Text('Pick a File'),
                onTap: () {
                  Navigator.of(context).pop('file');
                },
              ),
            ],
          ),
        );
      },
    );

    if (option != null && context.mounted) {
      if (option == 'gallery') {
        vm.pickFromGallery();
      } else if (option == 'file') {
        vm.pickFromFile();
      }
    }
  }
}

class _MediaPreview extends StatelessWidget {
  final String path;
  final bool isImage;

  const _MediaPreview({required this.path, required this.isImage});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child:
          isImage
              ? Image.file(
                File(path),
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _FilePlaceholder(colorScheme: colorScheme);
                },
              )
              : _FilePlaceholder(colorScheme: colorScheme),
    );
  }
}

class _FilePlaceholder extends StatelessWidget {
  final ColorScheme colorScheme;

  const _FilePlaceholder({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      color: colorScheme.secondaryContainer,
      alignment: Alignment.center,
      child: const Icon(Icons.insert_drive_file_rounded),
    );
  }
}
