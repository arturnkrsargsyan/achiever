import 'package:achiever/di/injectable.dart';
import 'package:achiever/firebase_options.dart';
import 'package:achiever/presentation/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void initializeAndRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();

  runApp(
    const AchieverApp(),
  );
}
