import 'package:flutter/material.dart';

class AddRecipeAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AddRecipeAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text("Add Recipe"));
  }
}
