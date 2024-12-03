import 'package:achiever/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AchieverApp extends StatelessWidget {
  const AchieverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        title: 'Achiever',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: Locator.router.config(),
      ),
    );
  }
}
