import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/presentation/core/router/app_router.dart';
import 'package:get_it/get_it.dart';

abstract class Locator {
  static final _gi = GetIt.instance;

  // Router
  static AppRouter get router => _gi.get<AppRouter>();

  // globals
  static AuthBloc get authBloc => _gi.get<AuthBloc>();
}
