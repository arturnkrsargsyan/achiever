part of 'user_performer_bloc.dart';

@freezed
class UserPerformerState with _$UserPerformerState {
  const factory UserPerformerState.initial() = _Initial;

  const factory UserPerformerState.inProgress() = _InProgress;

  const factory UserPerformerState.success() = _Success;

  const factory UserPerformerState.failure({
    required String message,
  }) = _Failure;
}
