import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/app/router/app_router.gr.dart';
import 'package:ryori/core/auth/auth_token_storage.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    _resolveInitialRoute();
  }

  Future<void> _resolveInitialRoute() async {
    final hasAccessToken = await getIt<AuthTokenStorage>().hasAccessToken();

    if (!mounted) {
      return;
    }

    await context.router.replace(
      hasAccessToken ? const HomeSetup() : const LoginSetup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
