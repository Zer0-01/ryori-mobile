import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/login/presentation/viewmodels/login_view_model.dart';
import 'package:ryori/features/login/presentation/views/login_view.dart';

@RoutePage()
class LoginSetup extends StatelessWidget {
  const LoginSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<LoginViewModel>(),
      child: const LoginView(),
    );
  }
}
