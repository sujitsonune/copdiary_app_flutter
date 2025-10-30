import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Forgot Password UseCase
/// Sends OTP to mobile for password reset
@lazySingleton
class ForgotPasswordUseCase implements UseCaseVoid<ForgotPasswordParams> {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    // Validate mobile number
    if (params.mobile.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Mobile number cannot be empty'),
      );
    }

    // Validate mobile format (10 digits)
    final mobileRegex = RegExp(AppConstants.phonePattern);
    if (!mobileRegex.hasMatch(params.mobile)) {
      return const Left(
        ValidationFailure(message: 'Please enter a valid 10-digit mobile number'),
      );
    }

    // Call repository to send OTP
    return await _repository.forgotPassword(mobile: params.mobile);
  }
}

/// Forgot Password Parameters
class ForgotPasswordParams extends Equatable {
  final String mobile;

  const ForgotPasswordParams({required this.mobile});

  @override
  List<Object?> get props => [mobile];

  factory ForgotPasswordParams.fromForm(String mobile) {
    return ForgotPasswordParams(mobile: mobile.trim());
  }
}
