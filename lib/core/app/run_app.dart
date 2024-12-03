import 'package:achiever/di/injectable.dart';
import 'package:achiever/presentation/app/app.dart';
import 'package:flutter/material.dart';

void initializeAndRunApp() async {
  configureDependencies();

  runApp(
    const AchieverApp(),
  );
}
