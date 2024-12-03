class AuthErrorCodes {
  final String _code;

  AuthErrorCodes(this._code);

  String _getErrorMessage(String code) {
    return switch (code) {
      'email-already-in-use' => 'The account already exists for that email.',
      'weak-password' => 'The password provided is too weak.',
      'invalid-email' => 'The email address is not valid.',
      'operation-not-allowed' => 'Email/password accounts are not enabled.',
      'user-disabled' => 'The user account has been disabled.',
      'user-not-found' => 'No user found for that email.',
      'invalid-credential' => 'Wrong password, please try again.',
      _ => 'Something went wrong. Please try again later.',
    };
  }

  String get message => _getErrorMessage(_code);
}
