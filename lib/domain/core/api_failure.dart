import 'package:achiever/domain/core/auth_failures.dart';

base class ApiFailure {
  final String message;
  final int? statusCode;

  const ApiFailure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return 'ApiFailure(message: $message, statusCode: $statusCode)';
  }

  factory ApiFailure.auth([AuthFailures? failure]) => ApiFailure(
        message: failure?.message ?? 'Authentication failed',
        statusCode: 401,
      );
}
