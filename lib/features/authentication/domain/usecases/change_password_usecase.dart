import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Change Password UseCase
/// Changes password for logged-in user
@lazySingleton
class ChangePasswordUseCase implements UseCaseVoid<ChangePasswordParams> {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    // Validate user ID
    if (params.userId.isEmpty) {
      return const Left(
        ValidationFailure(message: 'User ID is required'),
      );
    }

    // Validate old password
    if (params.oldPassword.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Current password cannot be empty'),
      );
    }

    // Validate new password
    if (params.newPassword.isEmpty) {
      return const Left(
        ValidationFailure(message: 'New password cannot be empty'),
      );
    }

    // Validate new password is different from old password
    if (params.oldPassword == params.newPassword) {
      return const Left(
        ValidationFailure(
          message: 'New password must be different from current password',
        ),
      );
    }

    // Validate password strength
    final passwordRegex = RegExp(AppConstants.passwordPattern);
    if (!passwordRegex.hasMatch(params.newPassword)) {
      return const Left(
        ValidationFailure(
          message:
              'Password must be at least 8 characters with letters and numbers',
        ),
      );
    }

    // Validate confirm password
    if (params.newPassword != params.confirmPassword) {
      return const Left(
        ValidationFailure(message: 'Passwords do not match'),
      );
    }

    // Call repository to change password
    return await _repository.changePassword(
      userId: params.userId,
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }
}

/// Change Password Parameters
class ChangePasswordParams extends Equatable {
  final String userId;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [userId, oldPassword, newPassword, confirmPassword];

  factory ChangePasswordParams.fromForm({
    required String userId,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return ChangePasswordParams(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
