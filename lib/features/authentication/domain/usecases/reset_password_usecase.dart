import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Reset Password UseCase
/// Resets password after OTP verification
@lazySingleton
class ResetPasswordUseCase implements UseCaseVoid<ResetPasswordParams> {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    // Validate mobile number
    if (params.mobile.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Mobile number cannot be empty'),
      );
    }

    // Validate mobile format
    final mobileRegex = RegExp(AppConstants.phonePattern);
    if (!mobileRegex.hasMatch(params.mobile)) {
      return const Left(
        ValidationFailure(message: 'Please enter a valid 10-digit mobile number'),
      );
    }

    // Validate OTP
    if (params.otp.isEmpty) {
      return const Left(
        ValidationFailure(message: 'OTP cannot be empty'),
      );
    }

    // Validate new password
    if (params.newPassword.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Password cannot be empty'),
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

    // Call repository to reset password
    return await _repository.resetPassword(
      mobile: params.mobile,
      otp: params.otp,
      newPassword: params.newPassword,
    );
  }
}

/// Reset Password Parameters
class ResetPasswordParams extends Equatable {
  final String mobile;
  final String otp;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordParams({
    required this.mobile,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [mobile, otp, newPassword, confirmPassword];

  factory ResetPasswordParams.fromForm({
    required String mobile,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) {
    return ResetPasswordParams(
      mobile: mobile.trim(),
      otp: otp.trim(),
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
