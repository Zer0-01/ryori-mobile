import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ryori/features/profile/presentation/views/profile_view.dart';

@RoutePage()
class ProfileSetup extends StatelessWidget {
  const ProfileSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}
