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
        BlocProvider(
          create: (_) => Locator.authBloc,
        ),
      ],
      child: child,
    );
  }
}
