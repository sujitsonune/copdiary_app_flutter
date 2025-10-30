import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Login UseCase
/// Validates credentials and performs login
@lazySingleton
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    // Validate username
    if (params.username.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Username cannot be empty'),
      );
    }

    // Validate password
    if (params.password.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Password cannot be empty'),
      );
    }

    // Validate password length (minimum 6 characters)
    if (params.password.length < 6) {
      return const Left(
        ValidationFailure(message: 'Password must be at least 6 characters'),
      );
    }

    // Validate username format (alphanumeric and underscore)
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(params.username)) {
      return const Left(
        ValidationFailure(
          message: 'Username can only contain letters, numbers, and underscore',
        ),
      );
    }

    // Call repository to perform login
    return await _repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

/// Login Parameters
class LoginParams extends Equatable {
  final String username;
  final String password;
  final bool rememberMe;

  const LoginParams({
    required this.username,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [username, password, rememberMe];

  /// Create from form data
  factory LoginParams.fromForm({
    required String username,
    required String password,
    bool rememberMe = false,
  }) {
    return LoginParams(
      username: username.trim(),
      password: password,
      rememberMe: rememberMe,
    );
  }
}
