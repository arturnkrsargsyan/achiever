part of 'achievement_performer_bloc.dart';

@freezed
class AchievementPerformerEvent with _$AchievementPerformerEvent {
  const factory AchievementPerformerEvent.create({
    required String title,
    required String description,
    required DateTime? startDate,
    required DateTime? endDate,
  }) = _Create;

  const factory AchievementPerformerEvent.update({
    required Achievement achievement,
  }) = _Update;

  const factory AchievementPerformerEvent.delete({
    required String achievementId,
  }) = _Delete;
}
