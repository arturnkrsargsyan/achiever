part of 'achievement_performer_bloc.dart';

@freezed
class AchievementPerformerState with _$AchievementPerformerState {
  const factory AchievementPerformerState.initial() = _Initial;

  const factory AchievementPerformerState.inProgress() = _InProgress;

  const factory AchievementPerformerState.success() = _Success;

  const factory AchievementPerformerState.failure({
    required String message,
  }) = _Failure;
}
