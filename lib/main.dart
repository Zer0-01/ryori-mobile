import 'package:flutter/material.dart';
import 'package:ryori/app/app.dart';
import 'package:ryori/app/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(App());
}
