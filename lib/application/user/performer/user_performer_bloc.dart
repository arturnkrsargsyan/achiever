import 'package:achiever/domain/user/i_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_performer_event.dart';
part 'user_performer_state.dart';
part 'user_performer_bloc.freezed.dart';

@injectable
class UserPerformerBloc extends Bloc<UserPerformerEvent, UserPerformerState> {
  final IUserRepository _userRepository;

  UserPerformerBloc(this._userRepository)
      : super(const UserPerformerState.initial()) {
    on<_Create>(_onCreate);
  }

  Future<void> wait() => stream.firstWhere(
        (state) => state.maybeMap(
          orElse: () => false,
          success: (_) => true,
        ),
      );

  void _onCreate(_Create event, Emitter<UserPerformerState> emit) async {
    emit(const UserPerformerState.inProgress());

    final result = await _userRepository.create();

    result.fold(
      (failure) => emit(UserPerformerState.failure(message: failure.message)),
      (_) => emit(const UserPerformerState.success()),
    );
  }
}
