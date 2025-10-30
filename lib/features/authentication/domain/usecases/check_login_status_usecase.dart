import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Check Login Status UseCase
/// Checks if user is currently logged in
@lazySingleton
class CheckLoginStatusUseCase implements UseCaseNoParams<bool> {
  final AuthRepository _repository;

  CheckLoginStatusUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call() async {
    // Check if user is logged in
    // Returns true if auth token exists and is valid
    return await _repository.isLoggedIn();
  }
}
