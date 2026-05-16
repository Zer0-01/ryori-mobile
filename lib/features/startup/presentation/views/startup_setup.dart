import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ryori/features/startup/presentation/views/startup_view.dart';

@RoutePage()
class StartupSetup extends StatelessWidget {
  const StartupSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const StartupView();
  }
}
