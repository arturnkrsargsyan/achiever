import 'dart:async';

import 'package:achiever/domain/user/entities/user.dart';
import 'package:achiever/domain/user/i_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_watcher_state.dart';
part 'user_watcher_cubit.freezed.dart';

@singleton
class UserWatcherCubit extends Cubit<UserWatcherState> {
  final IUserRepository _userRepository;

  UserWatcherCubit(this._userRepository)
      : super(const UserWatcherState.initial());

  StreamSubscription? _userSubscription;

  Future<void> wait() async {
    await stream.firstWhere(
      (state) => state.maybeMap(
        orElse: () => false,
        success: (_) => true,
      ),
    );
  }

  void watch() {
    _userSubscription?.cancel();

    final response = _userRepository.watch();

    response.fold(
      (failure) {
        emit(UserWatcherState.failure(message: failure.message));
        return null;
      },
      (stream) {
        _userSubscription = stream.listen(
          (user) {
            emit(
              UserWatcherState.success(user),
            );
          },
        );
      },
    );
  }

  void reset() {
    _userSubscription?.cancel();

    emit(const UserWatcherState.initial());
  }
}
