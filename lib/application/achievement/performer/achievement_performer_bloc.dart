import 'package:achiever/domain/achievement/entities/achievement.dart';
import 'package:achiever/domain/achievement/i_achievement_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'achievement_performer_event.dart';
part 'achievement_performer_state.dart';
part 'achievement_performer_bloc.freezed.dart';

@injectable
class AchievementPerformerBloc
    extends Bloc<AchievementPerformerEvent, AchievementPerformerState> {
  final IAchievementRepository _achievementRepository;

  AchievementPerformerBloc(this._achievementRepository)
      : super(const AchievementPerformerState.initial()) {
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_Delete>(_onDelete);
  }

  void _onCreate(
    _Create event,
    Emitter<AchievementPerformerState> emit,
  ) async {
    emit(const AchievementPerformerState.inProgress());

    final id = const Uuid().v4();

    final result = await _achievementRepository.save(
      Achievement(
        id: id,
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    result.fold(
      (failure) =>
          emit(AchievementPerformerState.failure(message: failure.message)),
      (_) => emit(
        const AchievementPerformerState.success(),
      ),
    );
  }

  void _onUpdate(_Update event, Emitter<AchievementPerformerState> emit) async {
    emit(const AchievementPerformerState.inProgress());

    final result = await _achievementRepository.update(event.achievement);

    result.fold(
      (failure) =>
          emit(AchievementPerformerState.failure(message: failure.message)),
      (_) => emit(
        const AchievementPerformerState.success(),
      ),
    );
  }

  void _onDelete(_Delete event, Emitter<AchievementPerformerState> emit) async {
    emit(const AchievementPerformerState.inProgress());

    final result = await _achievementRepository.delete(event.achievementId);

    result.fold(
      (failure) =>
          emit(AchievementPerformerState.failure(message: failure.message)),
      (_) => emit(
        const AchievementPerformerState.success(),
      ),
    );
  }
}
