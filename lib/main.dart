import 'package:daily_in/firebase_options.dart';
import 'package:daily_in/src/features/check_in/home_module.dart';
import 'package:daily_in/src/infrastructure/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HomeModule().dependencies();

  runApp(const App());
}
