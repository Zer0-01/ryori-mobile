import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/register/presentation/viewmodels/register_view_model.dart';
import 'package:ryori/features/register/presentation/views/register_view.dart';

@RoutePage()
class RegisterSetup extends StatelessWidget {
  const RegisterSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<RegisterViewModel>(),
      child: const RegisterView(),
    );
  }
}
