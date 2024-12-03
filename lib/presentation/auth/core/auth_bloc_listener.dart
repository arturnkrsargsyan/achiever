import 'dart:developer';

import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/presentation/core/in_app_notifications/toast.dart';
import 'package:achiever/presentation/core/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlocListener extends StatelessWidget {
  final Widget child;

  final VoidCallback? onFailure;

  const AuthBlocListener({
    required this.child,
    this.onFailure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        authState.whenOrNull(
          unauthenticated: () {
            context.router.replace(const AuthRoute());
          },
          failure: (message) {
            AppToast.error(message).show();

            onFailure?.call();
          },
          authenticated: (isNewUser) {
            log('User is authenticated, isNewUser: $isNewUser');

            context.router.replace(const HomeRoute());
            return;
          },
        );
      },
      child: child,
    );
  }
}
