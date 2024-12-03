import 'package:achiever/domain/auth/i_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState.initial()) {
    on<_SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<_SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<_SignInWithGoogle>(_onSignInWithGoogle);
    on<_SignOut>(_onSignOut);
    on<_Started>(_onStarted);
  }

  void _onSignInWithEmailAndPassword(
    _SignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.inProgress());

    final response = await _authRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (failure) {
        emit(AuthState.failure(failure.message));
      },
      (_) {
        emit(const AuthState.authenticated(isNewUser: false));
      },
    );
  }

  void _onSignUpWithEmailAndPassword(
    _SignUpWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.inProgress());

    final response = await _authRepository.signUpWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (failure) {
        emit(AuthState.failure(failure.message));
      },
      (_) {
        emit(const AuthState.authenticated(isNewUser: true));
      },
    );
  }

  void _onSignInWithGoogle(
    _SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.inProgress());

    final response = await _authRepository.signInWithGoogle();

    response.fold(
      (failure) {
        emit(AuthState.failure(failure.message));
      },
      (isNewUser) {
        emit(AuthState.authenticated(isNewUser: isNewUser));
      },
    );
  }

  void _onSignOut(
    _SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.inProgress());

    final response = await _authRepository.signOut();

    response.fold(
      (failure) {
        emit(AuthState.failure(failure.message));
      },
      (_) {
        emit(const AuthState.unauthenticated());
      },
    );
  }

  void _onStarted(
    _Started event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _authRepository.checkIfUserIsSignedIn();

    if (response) {
      emit(const AuthState.authenticated(isNewUser: false));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}
