import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/application/user/watcher/user_watcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './core/auth_global_listener.dart';

class AppGlobalListeners extends StatelessWidget {
  final Widget child;

  const AppGlobalListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: _authBlocListener,
        ),
      ],
      child: child,
    );
  }
}
