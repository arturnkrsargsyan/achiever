part of 'achievements_watcher_cubit.dart';

@freezed
class AchievementsWatcherState with _$AchievementsWatcherState {
  const factory AchievementsWatcherState.initial() = _Initial;

  const factory AchievementsWatcherState.inProgress() = _inProgress;

  const factory AchievementsWatcherState.success({
    required List<Achievement> achievements,
  }) = _Success;

  const factory AchievementsWatcherState.failure({
    required String message,
  }) = _Failure;
}
