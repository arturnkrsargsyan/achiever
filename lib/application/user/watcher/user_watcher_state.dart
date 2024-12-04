part of 'user_watcher_cubit.dart';

@freezed
class UserWatcherState with _$UserWatcherState {
  const factory UserWatcherState.initial() = _Initial;

  const factory UserWatcherState.success(User user) = _Success;

  const factory UserWatcherState.failure({
    required String message,
  }) = _Failure;

  const factory UserWatcherState.inProgress() = _InProgress;
}

extension UserWatcherStateX on UserWatcherState {
  User? get user => whenOrNull(
        success: (user) => user,
      );
}
