import 'package:equatable/equatable.dart';

/// Base Failure class for error handling in domain layer
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when server returns an error
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    String message = 'Server error occurred',
    this.statusCode,
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure when there's no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'No internet connection. Please check your network.',
  }) : super(message);
}

/// Failure when cache operations fail
class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Failed to load cached data',
  }) : super(message);
}

/// Failure when authentication fails
class AuthFailure extends Failure {
  const AuthFailure({
    String message = 'Authentication failed. Please login again.',
  }) : super(message);
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  const ValidationFailure({
    String message = 'Validation failed',
  }) : super(message);
}

/// Failure when timeout occurs
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    String message = 'Request timeout. Please try again.',
  }) : super(message);
}

/// Failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    String message = 'An unexpected error occurred',
  }) : super(message);
}
