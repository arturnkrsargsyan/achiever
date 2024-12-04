import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/application/user/performer/user_performer_bloc.dart';
import 'package:achiever/application/user/watcher/user_watcher_cubit.dart';
import 'package:achiever/presentation/core/router/app_router.dart';
import 'package:get_it/get_it.dart';

abstract class Locator {
  static final _gi = GetIt.instance;

  // Router
  static AppRouter get router => _gi.get<AppRouter>();

  // globals
  static AuthBloc get authBloc => _gi.get<AuthBloc>();

  // performers
  static UserPerformerBloc get userPerformerBloc =>
      _gi.get<UserPerformerBloc>();

  // Watchers
  static UserWatcherCubit get userWatcherCubit => _gi.get<UserWatcherCubit>();
}
