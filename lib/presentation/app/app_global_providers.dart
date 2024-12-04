import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/application/user/watcher/user_watcher_cubit.dart';
import 'package:achiever/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppGlobalProviders extends StatelessWidget {
  final Widget child;

  const AppGlobalProviders({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => Locator.authBloc,
        ),
        BlocProvider<UserWatcherCubit>(
          create: (_) => Locator.userWatcherCubit..watch(),
        ),
      ],
      child: child,
    );
  }
}
