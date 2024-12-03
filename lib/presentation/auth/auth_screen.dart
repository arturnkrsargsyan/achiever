import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/core/utils/reg_exp_validator.dart';
import 'package:achiever/presentation/auth/core/auth_bloc_listener.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSignUp = false;

  bool obscureText = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBlocListener(
      child: Scaffold(
        appBar: AppBar(
          title: Text(isSignUp ? 'Sign Up' : 'Sign In'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!RegExpValidator.isEmail(value)) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (RegExpValidator.isEmail(value)) {
                      return 'Please enter a valid password';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleMailAuth,
                  child: Text(isSignUp ? 'Sign Up' : 'Sign In'),
                ),
                TextButton(
                  onPressed: _toggleAuthMode,
                  child: Text(
                    isSignUp
                        ? 'Already have an account? Sign In'
                        : 'Don\'t have an account? Sign Up',
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.g_mobiledata),
                  onPressed: _handleGoogleSignIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleGoogleSignIn() {
    context.read<AuthBloc>().add(
          const AuthEvent.signInWithGoogle(),
        );
  }

  void _handleMailAuth() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (isSignUp) {
      context.read<AuthBloc>().add(
            AuthEvent.signUpWithEmailAndPassword(
              email: email,
              password: password,
            ),
          );
    } else {
      context.read<AuthBloc>().add(
            AuthEvent.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
          );
    }
  }

  void _toggleAuthMode() {
    _formKey.currentState!.reset();

    setState(() {
      isSignUp = !isSignUp;
    });
  }
}
