import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Get Current User UseCase
/// Retrieves the currently logged-in user from cache
@lazySingleton
class GetCurrentUserUseCase implements UseCaseNoParams<UserEntity> {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call() async {
    // Get cached user from repository
    // This reads from local storage without network call
    return await _repository.getCachedUser();
  }
}
