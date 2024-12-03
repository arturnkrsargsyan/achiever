import 'package:achiever/di/locator.dart';
import 'package:achiever/presentation/app/app_global_providers.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AchieverApp extends StatelessWidget {
  const AchieverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: AppGlobalProviders(
        child: MaterialApp.router(
          title: 'Achiever',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: Locator.router.config(),
        ),
      ),
    );
  }
}
