import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Logout UseCase
/// Clears local cache and logs out user
@lazySingleton
class LogoutUseCase implements UseCaseVoidNoParams {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call() async {
    // Call repository to perform logout
    // This will:
    // 1. Call remote logout API (best effort)
    // 2. Clear local cache (auth token, user data)
    // 3. Preserve credentials if remember me is enabled
    return await _repository.logout();
  }
}
