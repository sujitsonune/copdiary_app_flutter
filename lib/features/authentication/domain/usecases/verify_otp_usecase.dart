import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Verify OTP UseCase
/// Verifies OTP sent to mobile
@lazySingleton
class VerifyOtpUseCase implements UseCaseVoid<VerifyOtpParams> {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async {
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

    // Validate OTP length (typically 4-6 digits)
    if (params.otp.length < 4 || params.otp.length > 6) {
      return const Left(
        ValidationFailure(message: 'Please enter a valid OTP'),
      );
    }

    // Validate OTP format (digits only)
    final otpRegex = RegExp(r'^[0-9]+$');
    if (!otpRegex.hasMatch(params.otp)) {
      return const Left(
        ValidationFailure(message: 'OTP must contain only digits'),
      );
    }

    // Call repository to verify OTP
    return await _repository.verifyOtp(
      mobile: params.mobile,
      otp: params.otp,
    );
  }
}

/// Verify OTP Parameters
class VerifyOtpParams extends Equatable {
  final String mobile;
  final String otp;

  const VerifyOtpParams({
    required this.mobile,
    required this.otp,
  });

  @override
  List<Object?> get props => [mobile, otp];

  factory VerifyOtpParams.fromForm({
    required String mobile,
    required String otp,
  }) {
    return VerifyOtpParams(
      mobile: mobile.trim(),
      otp: otp.trim(),
    );
  }
}
