import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';
import '../models/signup_request_model.dart';

/// Implementation of AuthRepository
/// Handles network calls, caching, and error conversion
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  }) async {
    // Check network connectivity
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      // Create request model
      final request = LoginRequestModel(
        username: username,
        password: password,
      );

      // Call remote API
      final response = await _remoteDataSource.login(request);

      // Check if login was successful
      if (!response.success || response.data == null) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Login failed',
          ),
        );
      }

      // Extract user and token
      final user = response.data!.user;
      final token = response.data!.actualToken;

      // Cache user data and token
      await _localDataSource.cacheUserData(user);
      if (token != null && token.isNotEmpty) {
        await _localDataSource.cacheAuthToken(token);
      }

      return Right(user);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error occurred',
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'No internet connection'));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? 'Authentication failed'));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Failed to cache data'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
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
  }) async {
    // Check network connectivity
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      // Create request model
      final request = SignupRequestModel(
        username: username,
        password: password,
        fullName: fullName,
        buckleNo: buckleNo,
        mobile: mobile,
        email: email,
        designation: designation,
        policeStation: policeStation,
        district: district,
        state: state,
      );

      // Call remote API
      final response = await _remoteDataSource.signup(request);

      // Check if signup was successful
      if (!response.success || response.data == null) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Signup failed',
          ),
        );
      }

      // Extract user and token
      final user = response.data!.user;
      final token = response.data!.actualToken;

      // Cache user data and token
      await _localDataSource.cacheUserData(user);
      if (token != null && token.isNotEmpty) {
        await _localDataSource.cacheAuthToken(token);
      }

      return Right(user);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error occurred',
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'No internet connection'));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Failed to cache data'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({
    required String mobile,
  }) async {
    // Check network connectivity
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final response = await _remoteDataSource.forgotPassword(mobile);

      // Check if request was successful
      if (response['success'] != true) {
        return Left(
          ServerFailure(
            message: response['message'] ?? 'Failed to send OTP',
          ),
        );
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error occurred',
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'No internet connection'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    // Check network connectivity
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final response = await _remoteDataSource.verifyOtp(mobile, otp);

      // Check if OTP verification was successful
      if (response['success'] != true) {
        return Left(
          ServerFailure(
            message: response['message'] ?? 'Invalid OTP',
          ),
        );
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error occurred',
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'No internet connection'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String mobile,
    required String otp,
    required String newPassword,
  }) async {
    // Check network connectivity
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final response = await _remoteDataSource.resetPassword(
        mobile,
        otp,
        newPassword,
      );

      // Check if password reset was successful
      if (response['success'] != true) {
        return Left(
          ServerFailure(
            message: response['message'] ?? 'Failed to reset password',
          ),
        );
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error occurred',
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'No internet connection'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    // Check network connectivity
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final response = await _remoteDataSource.changePassword(
        userId,
        oldPassword,
        newPassword,
      );

      // Check if password change was successful
      if (response['success'] != true) {
        return Left(
          ServerFailure(
            message: response['message'] ?? 'Failed to change password',
          ),
        );
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error occurred',
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'No internet connection'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Try to call remote logout (best effort - don't fail if network is down)
      if (await _networkInfo.isConnected) {
        try {
          await _remoteDataSource.logout();
        } catch (e) {
          // Ignore remote logout errors - still clear local cache
        }
      }

      // Clear local cache
      await _localDataSource.clearCache();

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Failed to clear cache'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCachedUser() async {
    try {
      final user = await _localDataSource.getCachedUser();
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'No cached user found'));
    } catch (e) {
      return Left(UnexpectedFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final isLoggedIn = await _localDataSource.isLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      return const Right(false);
    }
  }
}
