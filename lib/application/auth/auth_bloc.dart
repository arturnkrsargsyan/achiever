import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<_SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<_SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<_SignInWithGoogle>(_onSignInWithGoogle);
    on<_SignOut>(_onSignOut);
    on<_Started>(_onStarted);
  }

  void _onSignInWithEmailAndPassword(
    _SignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {}

  void _onSignUpWithEmailAndPassword(
    _SignUpWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {}

  void _onSignInWithGoogle(
    _SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {}

  void _onSignOut(
    _SignOut event,
    Emitter<AuthState> emit,
  ) async {}

  void _onStarted(
    _Started event,
    Emitter<AuthState> emit,
  ) async {}
}
