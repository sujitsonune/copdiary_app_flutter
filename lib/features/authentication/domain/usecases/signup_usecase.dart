import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Signup UseCase
/// Validates user registration data and creates account
@lazySingleton
class SignupUseCase implements UseCase<UserEntity, SignupParams> {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignupParams params) async {
    // Validate username
    if (params.username.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Username cannot be empty'),
      );
    }

    // Validate username format
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(params.username)) {
      return const Left(
        ValidationFailure(
          message: 'Username can only contain letters, numbers, and underscore',
        ),
      );
    }

    // Validate username length
    if (params.username.length < 3) {
      return const Left(
        ValidationFailure(message: 'Username must be at least 3 characters'),
      );
    }

    // Validate password
    if (params.password.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Password cannot be empty'),
      );
    }

    // Validate password strength (using app constants pattern)
    final passwordRegex = RegExp(AppConstants.passwordPattern);
    if (!passwordRegex.hasMatch(params.password)) {
      return const Left(
        ValidationFailure(
          message:
              'Password must be at least 8 characters with letters and numbers',
        ),
      );
    }

    // Validate full name
    if (params.fullName.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Full name cannot be empty'),
      );
    }

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

    // Validate email if provided
    if (params.email != null && params.email!.isNotEmpty) {
      final emailRegex = RegExp(AppConstants.emailPattern);
      if (!emailRegex.hasMatch(params.email!)) {
        return const Left(
          ValidationFailure(message: 'Please enter a valid email address'),
        );
      }
    }

    // Validate buckle number if provided
    if (params.buckleNo != null && params.buckleNo!.isNotEmpty) {
      if (params.buckleNo!.length < 3) {
        return const Left(
          ValidationFailure(message: 'Buckle number must be at least 3 characters'),
        );
      }
    }

    // Call repository to perform signup
    return await _repository.signup(
      username: params.username,
      password: params.password,
      fullName: params.fullName,
      buckleNo: params.buckleNo,
      mobile: params.mobile,
      email: params.email,
      designation: params.designation,
      policeStation: params.policeStation,
      district: params.district,
      state: params.state,
    );
  }
}

/// Signup Parameters
class SignupParams extends Equatable {
  final String username;
  final String password;
  final String fullName;
  final String? buckleNo;
  final String mobile;
  final String? email;
  final String? designation;
  final String? policeStation;
  final String? district;
  final String? state;

  const SignupParams({
    required this.username,
    required this.password,
    required this.fullName,
    this.buckleNo,
    required this.mobile,
    this.email,
    this.designation,
    this.policeStation,
    this.district,
    this.state,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        fullName,
        buckleNo,
        mobile,
        email,
        designation,
        policeStation,
        district,
        state,
      ];

  /// Create from form data
  factory SignupParams.fromForm({
    required String username,
    required String password,
    required String fullName,
    String? buckleNo,
    required String mobile,
    String? email,
    String? designation,
    String? policeStation,
    String? district,
    String? state,
  }) {
    return SignupParams(
      username: username.trim(),
      password: password,
      fullName: fullName.trim(),
      buckleNo: buckleNo?.trim(),
      mobile: mobile.trim(),
      email: email?.trim(),
      designation: designation?.trim(),
      policeStation: policeStation?.trim(),
      district: district?.trim(),
      state: state?.trim(),
    );
  }

  /// Copy with
  SignupParams copyWith({
    String? username,
    String? password,
    String? fullName,
    String? buckleNo,
    String? mobile,
    String? email,
    String? designation,
    String? policeStation,
    String? district,
    String? state,
  }) {
    return SignupParams(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      buckleNo: buckleNo ?? this.buckleNo,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      designation: designation ?? this.designation,
      policeStation: policeStation ?? this.policeStation,
      district: district ?? this.district,
      state: state ?? this.state,
    );
  }
}
