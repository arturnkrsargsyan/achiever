part of '../app_global_listeners.dart';

extension AuthGlobalListenerX on AppGlobalListeners {
  void _authBlocListener(BuildContext context, AuthState state) {
    state.whenOrNull(
      unauthenticated: () {
        // Reset all global blocs/cubits
        context.read<UserWatcherCubit>().reset();
        context.read<AchievementsWatcherCubit>().reset();
      },
    );
  }
}
