import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/presentation/auth/core/auth_bloc_listener.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBlocListener(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Welcome to Achiever'),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signOut());
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
