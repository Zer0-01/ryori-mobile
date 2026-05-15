import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:ryori/features/home/presentation/views/home_view.dart';

@RoutePage()
class HomeSetup extends StatelessWidget {
  const HomeSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<HomeViewModel>(),
      child: const HomeView());
  }
}
