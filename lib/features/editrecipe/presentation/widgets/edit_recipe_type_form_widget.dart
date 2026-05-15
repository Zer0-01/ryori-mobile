import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/features/addrecipe/data/models/responses/type_response_dto.dart';
import 'package:ryori/features/editrecipe/presentation/viewmodels/edit_recipe_view_model.dart';

class EditRecipeTypeFormWidget extends StatelessWidget {
  final TextEditingController controller;

  const EditRecipeTypeFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditRecipeViewModel>(
      builder: (context, vm, child) {
        return TextFormField(
          controller: controller,
          readOnly: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Type cannot be empty';
            }

            return null;
          },
          onTap: () async {
            final TypeData? result = await showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return ListView.builder(
                  itemCount: vm.types.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(vm.types[index].name),
                      onTap: () {
                        Navigator.pop(context, vm.types[index]);
                      },
                    );
                  },
                );
              },
            );

            if (result != null && context.mounted) {
              controller.text = result.name;
            }
          },
          decoration: const InputDecoration(
            labelText: 'Type',
            hintText: 'Select recipe type',
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
          ),
        );
      },
    );
  }
}
