import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ryori/features/login/presentation/views/login_view.dart';

@RoutePage()
class LoginSetup extends StatelessWidget {
  const LoginSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
