import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Base UseCase interface for all use cases
/// Type: Return type from repository
/// Params: Parameters needed for the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// UseCase with no parameters
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// UseCase that doesn't return data (void)
abstract class UseCaseVoid<Params> {
  Future<Either<Failure, void>> call(Params params);
}

/// UseCase that doesn't return data and has no params
abstract class UseCaseVoidNoParams {
  Future<Either<Failure, void>> call();
}

/// No parameters marker class
class NoParams {
  const NoParams();
}
