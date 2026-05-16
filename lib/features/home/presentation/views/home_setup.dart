import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ryori/features/home/presentation/views/home_view.dart';

@RoutePage()
class HomeSetup extends StatelessWidget {
  const HomeSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
