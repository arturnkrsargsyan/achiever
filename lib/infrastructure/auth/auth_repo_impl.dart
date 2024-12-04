import 'dart:developer';

import 'package:achiever/domain/auth/i_auth_repository.dart';
import 'package:achiever/domain/core/api_failure.dart';
import 'package:achiever/domain/core/api_response.dart';
import 'package:achiever/domain/core/auth_failures.dart';
import 'package:achiever/infrastructure/core/auth_error_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepoImpl implements IAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<ApiResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      final message = AuthErrorCodes(e.code).message;

      return Left(
        ApiFailure(
          message: message,
        ),
      );
    } catch (e) {
      return Left(
        ApiFailure.auth(AuthFailures.signIn),
      );
    }
  }

  @override
  Future<ApiResponse<bool>> signInWithGoogle() async {
    try {
      const List<String> scopes = <String>[
        'email',
      ];

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: scopes,
      );

      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return const Left(
          ApiFailure(message: "Please, select a Google account"),
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final authCred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(authCred);

      final bool isNewUser =
          userCredential.additionalUserInfo?.isNewUser ?? false;

      return Right(isNewUser);
    } catch (e) {
      log(e.toString());

      return Left(
        ApiFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<ApiResponse> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      final currUser = _firebaseAuth.currentUser;

      await _firebaseAuth.signOut();

      final String? providerId = currUser?.providerData.first.providerId;

      if (providerId == 'google.com') {
        await googleSignIn.signOut();
      }

      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure.auth(AuthFailures.signOut),
      );
    }
  }

  @override
  Future<ApiResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      final message = AuthErrorCodes(e.code).message;

      return Left(
        ApiFailure(
          message: message,
        ),
      );
    } catch (e) {
      return Left(
        ApiFailure.auth(AuthFailures.signUp),
      );
    }
  }

  @override
  Future<bool> checkIfUserIsSignedIn() async {
    if (_firebaseAuth.currentUser == null) {
      return false;
    }

    await _firebaseAuth.currentUser?.reload();

    final user = _firebaseAuth.currentUser;

    return user != null;
  }
}
