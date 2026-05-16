import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/features/profile/presentation/viewmodels/profile_view_model.dart';
import 'package:ryori/features/profile/presentation/views/profile_view.dart';

@RoutePage()
class ProfileSetup extends StatelessWidget {
  const ProfileSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<ProfileViewModel>(),
      child: const ProfileView(),
    );
  }
}
