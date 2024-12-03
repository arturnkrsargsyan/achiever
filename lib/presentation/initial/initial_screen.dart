import 'dart:developer';

import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/presentation/auth/core/auth_bloc_listener.dart';
import 'package:achiever/presentation/core/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  void checkAndNavigate() {
    log(
      'Checking if user is authenticated',
    );

    context.read<AuthBloc>().add(const AuthEvent.started());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1500));

      checkAndNavigate();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocListener(
      onFailure: () => context.router.replace(
        const AuthRoute(),
      ),
      child: const Scaffold(
        body: Center(
          child: Text('Initial, Welcome to Achiever'),
        ),
      ),
    );
  }
}
