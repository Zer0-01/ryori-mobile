import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ryori/features/register/presentation/views/register_view.dart';

@RoutePage()
class RegisterSetup extends StatelessWidget {
  const RegisterSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterView();
  }
}
