import 'dart:async';

import 'package:achiever/domain/achievement/entities/achievement.dart';
import 'package:achiever/domain/achievement/i_achievement_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'achievements_watcher_state.dart';
part 'achievements_watcher_cubit.freezed.dart';

@singleton
class AchievementsWatcherCubit extends Cubit<AchievementsWatcherState> {
  final IAchievementRepository _achievementRepository;

  AchievementsWatcherCubit(this._achievementRepository)
      : super(const AchievementsWatcherState.initial());

  StreamSubscription? _subscription;

  void watch() {
    _subscription?.cancel();

    emit(const AchievementsWatcherState.inProgress());

    _achievementRepository.watchAll().fold(
      (failure) {
        emit(AchievementsWatcherState.failure(message: failure.message));
      },
      (stream) {
        _subscription = stream.listen(
          (achievements) {
            emit(AchievementsWatcherState.success(achievements: achievements));
          },
        );
      },
    );
  }

  void reset() {
    _subscription?.cancel();

    emit(const AchievementsWatcherState.initial());
  }
}
