import 'package:achiever/di/locator.dart';
import 'package:achiever/presentation/app/app_global_listeners.dart';
import 'package:achiever/presentation/app/app_global_providers.dart';
import 'package:achiever/presentation/core/ui/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AchieverApp extends StatelessWidget {
  const AchieverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: AppGlobalProviders(
        child: AppGlobalListeners(
          child: MaterialApp.router(
            title: 'Achiever',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: AppColors.white,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                selectionColor: AppColors.primary,
                selectionHandleColor: AppColors.primary,
                cursorColor: AppColors.primary,
              ),
              primaryColor: AppColors.primary,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primary,
                secondary: AppColors.secondary,
              ),
            ),
            routerConfig: Locator.router.config(),
          ),
        ),
      ),
    );
  }
}
