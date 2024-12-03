import 'package:achiever/domain/core/api_response.dart';

abstract interface class IAuthRepository {
  Future<ApiResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<ApiResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> checkIfUserIsSignedIn();

  Future<ApiResponse<bool>> signInWithGoogle();

  Future<ApiResponse> signOut();
}
