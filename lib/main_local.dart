import 'package:flutter/material.dart';
import 'package:ryori/app/app.dart';
import 'package:ryori/app/di/injection.dart';
import 'package:ryori/core/env/app_env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment: AppEnvironment.local);
  runApp(App());
}
