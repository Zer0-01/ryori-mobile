import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:ryori/app/router/app_router.dart';
import 'package:ryori/app/router/app_router_observer.dart';
import 'package:ryori/core/theme/app_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(
            navigatorObservers: () => [AppRouterObserver()],
          ),
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
