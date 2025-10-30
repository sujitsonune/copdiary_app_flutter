import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Authentication Repository Interface
/// Defines contracts for authentication operations
abstract class AuthRepository {
  /// Login with username and password
  /// Returns Either<Failure, UserEntity>
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  });

  /// Sign up new user
  /// Returns Either<Failure, UserEntity>
  Future<Either<Failure, UserEntity>> signup({
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
  });

  /// Forgot password - send OTP
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> forgotPassword({
    required String mobile,
  });

  /// Verify OTP
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> verifyOtp({
    required String mobile,
    required String otp,
  });

  /// Reset password
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> resetPassword({
    required String mobile,
    required String otp,
    required String newPassword,
  });

  /// Change password
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  /// Logout
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> logout();

  /// Get cached user
  /// Returns Either<Failure, UserEntity>
  Future<Either<Failure, UserEntity>> getCachedUser();

  /// Check if user is logged in
  /// Returns Either<Failure, bool>
  Future<Either<Failure, bool>> isLoggedIn();
}
