import 'package:flutter/material.dart';

class EditRecipeAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const EditRecipeAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('Edit Recipe'));
  }
}
