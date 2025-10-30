/// Custom Exceptions for Copdiary Application

/// Exception thrown when server returns an error response
class ServerException implements Exception {
  final String? message;
  final int? statusCode;

  ServerException({this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status Code: $statusCode)';
}

/// Exception thrown when there's no internet connection
class NetworkException implements Exception {
  final String? message;

  NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when cache operations fail
class CacheException implements Exception {
  final String? message;

  CacheException({this.message = 'Failed to perform cache operation'});

  @override
  String toString() => 'CacheException: $message';
}

/// Exception thrown when authentication fails
class AuthException implements Exception {
  final String? message;

  AuthException({this.message = 'Authentication failed'});

  @override
  String toString() => 'AuthException: $message';
}

/// Exception thrown when validation fails
class ValidationException implements Exception {
  final String? message;

  ValidationException({this.message = 'Validation failed'});

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when timeout occurs
class TimeoutException implements Exception {
  final String? message;

  TimeoutException({this.message = 'Request timeout'});

  @override
  String toString() => 'TimeoutException: $message';
}
