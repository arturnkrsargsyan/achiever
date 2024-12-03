enum AuthFailures {
  signIn('Sign in failed'),
  signUp('Sign up failed'),
  signOut('Sign out failed'),
  signInWithGoogle('Sign in with Google failed'),
  ;

  const AuthFailures(this.message);

  final String message;
}
